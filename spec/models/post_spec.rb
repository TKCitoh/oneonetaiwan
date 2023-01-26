# frozen_string_literal: true

require "rails_helper"

RSpec.describe Post, "Postモデルのテスト", type: :model do
  describe "バリデーションのテスト" do
    subject { post.valid? }

    let(:end_user) { create(:end_user) }
    let!(:post) { build(:post, end_user_id: end_user.id) }

    context "titleカラム" do
      it "空欄でないこと" do
        post.title = ""
        is_expected.to eq false
      end
    end

    context "captionカラム" do
      it "空欄でないこと" do
        post.caption = ""
        is_expected.to eq false
      end
      it "20文字以下であること" do
        post.caption = Faker::Lorem.characters(number: 21)
        expect(post.valid?).to eq false
      end
    end

    context "imageカラム" do
      it "空欄でないこと" do
        post.image = ""
        is_expected.to eq false
      end
    end

    context "latitudeカラム" do
      it "空欄でないこと" do
        post.latitude = ""
        is_expected.to eq false
      end
    end

    context "longitudeカラム" do
      it "空欄でないこと" do
        post.longitude = ""
        is_expected.to eq false
      end
    end
  end

  describe "アソシエーションのテスト" do
    context "EndUserモデルとの関係" do
      it "N:1となっている" do
        expect(Post.reflect_on_association(:end_user).macro).to eq :belongs_to
      end
    end
  end
end
