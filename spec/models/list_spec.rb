# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Listモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { list.valid? }

    let(:user) { create(:user) }
    let!(:list) { build(:list, user_id: user.id) }

    context 'first_itemカラム' do
      it '空欄でないこと' do
        list.first_item = ''
        is_expected.to eq false
      end
      it '200文字以下であること: 200文字は〇' do
        list.first_item = Faker::Lorem.characters(number: 200)
        is_expected.to eq true
      end
      it '200文字以下であること: 201文字は×' do
        list.first_item = Faker::Lorem.characters(number: 201)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Userモデルとの関係' do
      it 'N:1となっている' do
        expect(List.reflect_on_association(:user).macro).to eq :belongs_to
      end
    end
  end
end
