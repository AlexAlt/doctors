require('capybara/rspec')
require('./app')
require('spec_helper')

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe('adds a doctor to the home page', {:type => :feature}) do
  it('processes the user entry and adds a new doctor') do
    visit('/')
    fill_in("name", :with => 'Bill')
    click_button('Add it!!')
    expect(page).to have_content('Success!')
  end
end
