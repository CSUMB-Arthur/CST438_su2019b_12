require 'rails_helper'

RSpec.describe "orders/index", type: :view do
  before(:each) do
    assign(:orders, [
      Order.create!(
        :itemId => 2,
        :customerId => 3,
        :description => "Description",
        :price => 4.5,
        :award => 5.5,
        :total => 6.5
      ),
      Order.create!(
        :itemId => 2,
        :customerId => 3,
        :description => "Description",
        :price => 4.5,
        :award => 5.5,
        :total => 6.5
      )
    ])
  end

  it "renders a list of orders" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
    assert_select "tr>td", :text => "Description".to_s, :count => 2
    assert_select "tr>td", :text => 4.5.to_s, :count => 2
    assert_select "tr>td", :text => 5.5.to_s, :count => 2
    assert_select "tr>td", :text => 6.5.to_s, :count => 2
  end
end
