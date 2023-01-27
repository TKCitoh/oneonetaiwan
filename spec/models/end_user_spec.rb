require "rails_helper"

RSpec.describe EndUser, "EndUserモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    before do
      @end_user = FactoryBot.build(:end_user)
    end

    it 'name,email,password,password_comfirmationの値が存在すれば登録できること' do
      expect(@end_user).to be_valid
    end

    it "nameが空欄でないこと" do
      @end_user.name = ""
      @end_user.valid?
      expect(@end_user.errors.full_messages).to include("Name can't be blank")
    end

    it 'emailが空欄でないこと' do
      @end_user.email = ''
      @end_user.valid?
      expect(@end_user.errors.full_messages).to include("Email can't be blank")
    end

    it '同じメールアドレスを登録できないこと' do
      end_user1 = FactoryBot.create(:end_user)
      @end_user.email = end_user1.email
      @end_user.valid?
      expect(@end_user.errors.full_messages).to include("Email has already been taken")
    end

    it '@のないメールアドレスを登録できないこと' do
      @end_user.email = Faker::Lorem.characters(number: 10, min_alpha: 10)
      @end_user.valid?
      expect(@end_user.errors.full_messages).to include("Email is invalid")
    end

    it 'passwordが空では登録できないこと' do
      @end_user.password = ''
      @end_user.valid?
      expect(@end_user.errors.full_messages).to include("Password can't be blank", "Password confirmation doesn't match Password", "Password は半角英数で入力して下さい")
    end

    it 'paswordが文字数５文字では登録できないこと' do
      @end_user.password = Faker::Lorem.characters(number: 5, min_alpha: 1, min_numeric: 1)
      @ebd_user.valid?
      expect(@end_user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

    it 'password_confirmationが空では登録できないこと' do
      @end_user.password_confirmation = ''
      @end_user.valid?
      expect(@end_user.errors.full_messages).to include("Password confirmation は半角英数で入力して下さい")
    end

    it 'passwordとpassword_confirmationが一致しないと登録できないこと' do
      @end_user.password = Faker::Lorem.characters(number: 7, min_alpha: 3, min_numeric: 1)
      @end_user.password_confirmation =  Faker::Lorem.characters(number: 6, min_alpha: 3, min_numeric: 2)
      @end_user.valid?
      expect(@end_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'password_confirmationが文字数５文字では登録できないこと' do
      @end_user.password_confirmation = Faker::Lorem.characters(number: 5, min_alpha: 1, min_numeric: 1)
      @end_user.valid?
      expect(@end_user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Postモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:posts).macro).to eq :has_many
      end
    end

    context 'Likeモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:likes).macro).to eq :has_many
      end
    end

    context 'Commentモデルとの関係' do
      it '1:Nとなっている' do
        expect(EndUser.reflect_on_association(:comments).macro).to eq :has_many
      end
    end
  end
end
