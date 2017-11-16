feature 'filter links by tag' do
  scenario 'when looking at path tags bubbles' do
    visit '/links/new'
    fill_in 'url',   with: 'http://www.makersacademy.com/'
    fill_in 'title', with: 'Makers Academy'
    fill_in 'tag',  with: 'education'
    click_button 'Submit'
    visit '/links/new'
    fill_in 'url',   with: 'http://www.google.com/'
    fill_in 'title', with: 'google'
    fill_in 'tag',  with: 'bubbles'
    click_button 'Submit'
    visit '/tag/bubbles'
    expect(page).to have_content 'google'
    expect(page).to have_no_content 'Makers Academy'
  end
end
