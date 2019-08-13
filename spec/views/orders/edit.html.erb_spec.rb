require 'rails_helper'

RSpec.describe "orders/edit", type: :view do
  before(:each) do
    @order = assign(:order, Order.create!(
      :itemId => 1,
      :customerId => 1,
      :description => "MyString",
      :price => 1.5,
      :award => 1.5,
      :total => 1.5
    ))
  end

  it "renders the edit order form" do
    render

    assert_select "form[action=?][method=?]", order_path(@order), "post" do

      assert_select "input#order_itemId[name=?]", "order[itemId]"

      assert_select "input#order_customerId[name=?]", "order[customerId]"

      assert_select "input#order_description[name=?]", "order[description]"

      assert_select "input#order_price[name=?]", "order[price]"

      assert_select "input#order_award[name=?]", "order[award]"

      assert_select "input#order_total[name=?]", "order[total]"
    end
  end
end
