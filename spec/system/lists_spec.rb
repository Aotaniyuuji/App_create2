# frozen_string_literal: true

require 'rails_helper'

describe '投稿のテスト' do
  let! visit root_path
  describe 'トップ画面(top_path)のテスト' do
    before 'トップ画面への遷移' do
      visit root_path
    end
    context '表示の確認' do
      it 'トップ画面(top_path)に「ここはTopページです」が表示されているか' do
        expect(page).to heve_content('ここはトップページです')
      end
      it 'top_pathが"/top"であるか' do
        expect(current_path).to eq '/top'
      end
    end
  end
end

describe '投稿画面のテスト' do
  before '投稿画面への遷移' do
    visit new_list_path
  end
  context '表示の確認' do
    it 'new_list_pathが"/lists/newであるか"' do
      expect(current_path).to eq('/lists/new')
    end
    it '投稿ボタンが表示されているか' do
      expect(page).to have_button '投稿'
    end
  end
  context '投稿処理のテスト' do
    it '投稿後のリダイレクト先は正しいか' do
      fill_in 'list[title]', with: Faker::Lorem.characters(number:10)
      fill_in 'list[body]', with: Faker::Lorem.characters(number:30)
      click_button 'Create List'
      expect(page).to have_current_path list_path(List.last)
    end
  end

  describe '一覧画面のテスト' do
    before '一覧画面への遷移' do
      visit lists_path
    end
    context '一覧画面の表示とリンクの確認' do
      it '一覧表示画面に投稿されたものが表示されているか' do
        expect(page).to have_content list.title
        expect(page).to have_link list.title
      end
    end
  end

  describe '詳細画面のテスト' do
    before '詳細画面への確認' do
      visit show_path
    end
    context '表示の確認' do
      it '削除リンクが存在しているか' do
        expect(page).to have_link '削除リンク'
      end
      it '編集リンクが存在しているか' do
        expect(page).to have_link '編集リンク'
      end
    end
    context 'リンクの遷移先の確認' do
      it '編集の遷移先は編集画面か' do
        edit_link = find_all()
        expect(edit_link.native.inner_text).to include('/edit')
      end
    end
    context 'list削除のテスト' do
      it 'listの削除' do
        expect { list.destroy }.to change{ Book.count }.by(-1)
      end
    end
  end

  dexcribe '編集画面のテスト' do
    before '編集画面への遷移' do
      visit edit_path
    end
    context '表示の確認' do
      it '編集前のタイトルと本文がフォームに表示(セット)されている' do
        expect()
      end
      it '保存ボタンが表示される' do
        expect(page).to have_button '保存'
      end
    end
    context '更新処理に関するテスト' do
      it '更新後のリダイレクト先は正しいか' do
        fill_in 'list[title]', with: Faker::Lorem.characters(number:10)
        fill_in 'list[body]', with: Faker::Lorem.characters(number:30)
        click_button 'Update List'
        expect(page).to have_current_path list_path(list)
      end
    end
  end
end
