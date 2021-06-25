# frozen_string_literal: true
require 'rails_helper'

describe '[STEP3] 仕上げのテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:list) { create(:list, user: user) }
  let!(:other_list) { create(:list, user: other_user) }

  describe 'サクセスメッセージのテスト' do
    subject { page }

    it 'ユーザ新規登録成功時' do
      visit new_user_registration_path
      fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
      fill_in 'user[email]', with: 'a' + user.email # 確実にuser, other_userと違う文字列にするため
      fill_in 'user[password]', with: 'password'
      fill_in 'user[password_confirmation]', with: 'password'
      click_button 'Sign up'
      is_expected.to have_content 'ようこそほめホメへ！'
    end
    it 'ユーザログイン成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      is_expected.to have_content 'ようこそほめホメへ！'
    end
    it 'ユーザログアウト成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      logout_link = find_all('a')[3].native.inner_text
      logout_link = logout_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
      click_link logout_link
      is_expected.to have_content 'ログアウトしました'
    end
    it 'ユーザのプロフィール情報更新成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      visit edit_user_path(user)
      click_button '変更内容を保存'
      is_expected.to have_content 'ユーザ情報を更新しました'
    end
    it '投稿データの新規投稿成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      visit new_list_path
      fill_in 'list[date]', with: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
      fill_in 'list[first_item]', with: Faker::Lorem.characters(number: 20)
      click_button '投稿'
      is_expected.to have_content 'リストを投稿しました'
    end
    it '投稿データの更新成功時' do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
      visit edit_list_path(list)
      click_button '変更内容を保存'
      is_expected.to have_content 'リストを更新しました'
    end
  end

  describe '処理失敗時のテスト' do
    context 'ユーザ新規登録失敗: nameを1文字にする' do
      before do
        visit new_user_registration_path
        @name = Faker::Lorem.characters(number: 1)
        @email = 'a' + user.email # 確実にuser, other_userと違う文字列にするため
        fill_in 'user[name]', with: @name
        fill_in 'user[email]', with: @email
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      end

      it '新規登録されない' do
        expect { click_button 'Sign up' }.not_to change(User.all, :count)
      end
      it '新規登録画面を表示しており、フォームの内容が正しい' do
        click_button 'Sign up'
        expect(page).to have_content 'Sign up'
        expect(page).to have_field 'user[name]', with: @name
        expect(page).to have_field 'user[email]', with: @email
      end
      it 'バリデーションエラーが表示される' do
        click_button 'Sign up'
        expect(page).to have_content "名前は2文字以上で入力してください"
      end
    end

    context 'ユーザのプロフィール情報編集失敗: nameを1文字にする' do
      before do
        @user_old_name = user.name
        @name = Faker::Lorem.characters(number: 1)
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        visit edit_user_path(user)
        fill_in 'user[name]', with: @name
        click_button '変更内容を保存'
      end

      it '更新されない' do
        expect(user.reload.name).to eq @user_old_name
      end
      it 'ユーザ編集画面を表示しており、フォームの内容が正しい' do
        expect(page).to have_field 'user[name]', with: @name
      end
      it 'バリデーションエラーが表示される' do
        expect(page).to have_content "名前は2文字以上で入力してください"
      end
    end

    context '投稿データの新規投稿失敗: dateを空にする' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        visit new_list_path
        @first_item = Faker::Lorem.characters(number: 19)
        fill_in 'list[first_item]', with: @first_item
      end

      it '投稿が保存されない' do
        expect { click_button '投稿' }.not_to change(List.all, :count)
      end
      it '投稿一覧画面を表示している' do
        click_button '投稿'
        expect(current_path).to eq '/lists'
        expect(page).to have_content list.first_item
        expect(page).to have_content other_list.first_item
      end
      it '新規投稿フォームの内容が正しい' do
        expect(find_field('list[date]').text).to be_blank
        expect(page).to have_field 'list[first_item]', with: @first_item
      end
      it 'バリデーションエラーが表示される' do
        click_button '投稿'
        expect(page).to have_content "を入力してください"
      end
    end

    context '投稿データの更新失敗: dateを空にする' do
      before do
        visit new_user_session_path
        fill_in 'user[email]', with: user.email
        fill_in 'user[password]', with: user.password
        click_button 'Log in'
        visit edit_list_path(list)
        @list_old_date = list.date
        fill_in 'list[date]', with: ''
        click_button '変更内容を保存'
      end

      it '投稿が更新されない' do
        expect(list.reload.date).to eq @list_old_date
      end
      it '投稿編集画面を表示しており、フォームの内容が正しい' do
        expect(current_path).to eq '/lists/' + list.id.to_s
        expect(find_field('list[date]').text).to be_blank
        expect(page).to have_field 'list[first_item]', with: list.first_item
      end
      it 'エラーメッセージが表示される' do
        expect(page).to have_content ''
      end
    end
  end

  describe 'ログインしていない場合のアクセス制限のテスト: アクセスできず、ログイン画面に遷移する' do
    subject { current_path }

    it 'ユーザ検索結果一覧画面' do
      visit users_path
      is_expected.to eq '/users/sign_in'
    end
    it 'ユーザ詳細(マイページ)画面' do
      visit mypage_path(user)
      is_expected.to eq '/users/sign_in'
    end
    it 'ユーザ情報編集画面' do
      visit edit_user_path(user)
      is_expected.to eq '/users/sign_in'
    end
    it '投稿一覧画面' do
      visit lists_path
      is_expected.to eq '/users/sign_in'
    end
    it '投稿詳細画面' do
      visit list_path(list)
      is_expected.to eq '/users/sign_in'
    end
    it '投稿編集画面' do
      visit edit_list_path(list)
      is_expected.to eq '/users/sign_in'
    end
  end

  describe '他人の画面のテスト' do
    before do
      visit new_user_session_path
      fill_in 'user[email]', with: user.email
      fill_in 'user[password]', with: user.password
      click_button 'Log in'
    end

    describe '他人の投稿詳細画面のテスト' do
      before do
        visit list_path(other_list)
      end

      context '表示内容の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/lists/' + other_list.id.to_s
        end
        it 'ユーザ画像・名前のリンク先が正しい' do
          expect(page).to have_link other_list.user.name, href: mypage_path(other_list.user)
        end
        it '投稿のdateが表示される' do
          expect(page).to have_content other_list.date
        end
        it '投稿のfirst_itemが表示される' do
          expect(page).to have_content other_list.first_item
        end
        it '投稿の編集リンクが表示されない' do
          expect(page).not_to have_link '編集'
        end
        it '投稿の削除リンクが表示されない' do
          expect(page).not_to have_link '削除'
        end
      end

      context '他人の投稿編集画面' do
       it '遷移できず、投稿一覧画面にリダイレクトされる' do
         visit edit_list_path(other_list)
          expect(current_path).to eq '/lists'
        end
      end
    end

    describe '他人のユーザ詳細画面のテスト' do
      before do
        visit mypage_path(other_user)
      end

      context '表示の確認' do
        it 'URLが正しい' do
          expect(current_path).to eq '/mypage/' + other_user.id.to_s
        end
        it '投稿一覧のユーザ画像のリンク先が正しい' do
          expect(page).to have_link '', href: mypage_path(other_user)
        end
        it '投稿一覧に他人の投稿のdateが表示され、リンクが正しい' do
          expect(page).to have_link '', href: list_path(other_list)
        end
        it '投稿一覧に他人の投稿のopinionが表示される' do
          expect(page).to have_content other_list.first_item
        end
        it '自分の投稿は表示されない' do
          expect(page).not_to have_content list.date
          expect(page).not_to have_content list.first_item
        end
      end

      context 'マイページの確認' do
        it '他人の名前と紹介文が表示される' do
          expect(page).to have_content other_user.name
          expect(page).to have_content other_user.introduction
        end
        it '自分の名前と紹介文は表示されない' do
          expect(page).not_to have_content user.introduction
        end
        it '自分のユーザ編集画面へのリンクは存在しない' do
          expect(page).not_to have_link '', href: edit_user_path(user)
        end
      end
    end
  end
end