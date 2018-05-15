# == Schema Information
#
# Table name: goals
#
#  id         :bigint(8)        not null, primary key
#  user_id    :integer          not null
#  title      :string           not null
#  details    :string
#  visibility :boolean          default(TRUE), not null
#  complete   :boolean          default(FALSE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :goal do
    user_id "MyString"
    title "MyString"
    details "MyString"
    visibility "MyString"
    complete "MyString"
  end
end
