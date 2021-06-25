# frozen_string_literal: true
require 'rails_helper'

describe '[STEP2] ユーザログイン後のテスト' do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:list) { create(:list, user: user) }
  let!(:other_list) { create(:list, user: other_user) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'Log in'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済みになります。' do
      subject { current_path }

      it 'Mypageを押すと、自分のマイページ画面に遷移する' do
        mypage_link = find_all('a')[0].native.inner_text
        mypage_link = mypage_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link mypage_link
        is_expected.to eq '/mypage/' + user.id.to_s
      end
      it 'Listを押すと、リスト一覧画面に遷移する' do
        list_link = find_all('a')[1].native.inner_text
        list_link = list_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link list_link
        is_expected.to eq '/lists'
      end
      it 'Calendarを押すと、カレンダー画面に遷移する' do
        calendar_link = find_all('a')[2].native.inner_text
        calendar_link = calendar_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link calendar_link
        is_expected.to eq '/my_calendar/' + user.id.to_s
      end
    end
  end

  describe '投稿一覧画面のテスト' do
    before do
      visit lists_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/lists'
      end
      it '自分と他人の画像のリンク先が正しい' do
        expect(page).to have_link '', href: mypage_path(list.user)
        expect(page).to have_link '', href: mypage_path(other_list.user)
      end
      it '自分の投稿と他人の投稿の日付のリンク先がそれぞれ正しい' do
        expect(page).to have_link '', href: list_path(list)
        expect(page).to have_link '', href: list_path(other_list)
      end
      it '自分の投稿と他人の投稿の項目が表示される' do
        expect(page).to have_content list.first_item
        expect(page).to have_content other_list.first_item
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'list[date]', with: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
        fill_in 'list[first_item]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(user.lists, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button '投稿'
        expect(current_path).to eq '/lists/' + List.last.id.to_s
      end
    end
  end

  describe '自分の投稿詳細画面のテスト' do
    before do
      visit list_path(list)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/lists/' + list.id.to_s
      end
      it 'ユーザ画像・名前のリンク先が正しい' do
        expect(page).to have_link list.user.name, href: mypage_path(list.user)
      end
      it '投稿のdateが表示される' do
        expect(page).to have_content list.date
      end
      it '投稿のfirst_itemが表示される' do
        expect(page).to have_content list.first_item
      end
      it '投稿の編集リンクが表示される' do
        expect(page).to have_link '編集', href: edit_list_path(list)
      end
      it '投稿の削除リンクが表示される' do
        expect(page).to have_link '削除', href: list_path(list)
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'list[date]', with: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
        fill_in 'list[first_item]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '投稿' }.to change(user.lists, :count).by(1)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        click_link '編集'
        expect(current_path).to eq '/lists/' + list.id.to_s + '/edit'
      end
    end

    context '削除リンクのテスト' do
      before do
        click_link '削除'
      end

      it '正しく削除される' do
        expect(List.where(id: list.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq '/lists'
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_list_path(list)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/lists/' + list.id.to_s + '/edit'
      end
      it 'date編集フォームが表示される' do
        expect(page).to have_field 'list[date]', with: list.date
      end
      it 'first_item編集フォームが表示される' do
        expect(page).to have_field 'list[first_item]', with: list.first_item
      end
      it '変更内容を保存ボタンが表示される' do
        expect(page).to have_button '変更内容を保存'
      end
      it 'キャンセルボタンが表示される' do
        expect(page).to have_link 'キャンセル', href: list_path(list)
      end
    end

    context '編集成功のテスト' do
      before do
        @list_old_date = list.date
        @list_old_first_item = list.first_item
        fill_in 'list[date]', with: Faker::Time.between(from: DateTime.now - 1, to: DateTime.now)
        fill_in 'list[first_item]', with: Faker::Lorem.characters(number: 19)
        click_button '変更内容を保存'
      end

      it 'dateが正しく更新される' do
        expect(list.reload.date).not_to eq @list_old_date
      end
      it 'first_itemが正しく更新される' do
        expect(list.reload.first_item).not_to eq @list_old_first_item
      end
      it 'リダイレクト先が、更新した投稿の詳細画面になっている' do
        expect(current_path).to eq '/lists/' + list.id.to_s
      end
    end
  end

  describe '自分のマイページ画面のテスト' do
    before do
      visit mypage_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/mypage/' + user.id.to_s
      end
      it '投稿一覧のユーザ画像のリンク先が正しい' do
        expect(page).to have_link '', href: mypage_path(user)
      end
      it '投稿一覧に自分の投稿のdateが表示され、リンクが正しい' do
        expect(page).to have_link '', href: list_path(list)
      end
      it '投稿一覧に自分の投稿のfirst_itemが表示される' do
        expect(page).to have_content list.first_item
      end
      it '他人の投稿は表示されない' do
        expect(page).not_to have_link '', href: user_path(other_user)
        expect(page).not_to have_content other_list.date
        expect(page).not_to have_content other_list.first_item
      end
    end
  end

  describe '自分のマイページ編集画面のテスト' do
    before do
      visit edit_user_path(user)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/users/' + user.id.to_s + '/edit'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[profile_image]'
      end
      it '自己紹介編集フォームに自分の自己紹介文が表示される' do
        expect(page).to have_field 'user[introduction]', with: user.introduction
      end
      it 'Update Userボタンが表示される' do
        expect(page).to have_button '変更内容を保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_intrpduction = user.introduction
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 9)
        fill_in 'user[introduction]', with: Faker::Lorem.characters(number: 19)
        click_button '変更内容を保存'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'introductionが正しく更新される' do
        expect(user.reload.introduction).not_to eq @user_old_intrpduction
      end
      it 'リダイレクト先が、自分のマイページ画面になっている' do
        expect(current_path).to eq '/mypage/' + user.id.to_s
      end
    end
  end
end