require './app/models/link.rb'
#require 'spec_helper.rb'

feature 'index' do
  scenario 'there is a link' do

    visit ('/links')
    Link.create(url: 'https://www.bbc.co.uk', title: 'BBC')
    expect(page).to have_content('BBC')
  end
end
