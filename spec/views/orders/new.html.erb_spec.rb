require 'rails_helper'

RSpec.describe "orders/new", type: :view do
  before(:each) do
    assign(:order, Order.new(
      :itemId => 1,
      :customerId => 1,
      :description => "MyString",
      :price => 1.5,
      :award => 1.5,
      :total => 1.5
    ))
  end

  it "renders new order form" do
    render

    assert_select "form[action=?][method=?]", orders_path, "post" do

      assert_select "input#order_itemId[name=?]", "order[itemId]"

      assert_select "input#order_customerId[name=?]", "order[customerId]"

      assert_select "input#order_description[name=?]", "order[description]"

      assert_select "input#order_price[name=?]", "order[price]"

      assert_select "input#order_award[name=?]", "order[award]"

      assert_select "input#order_total[name=?]", "order[total]"
    end
  end
end
