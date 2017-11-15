feature 'tag links' do
  scenario 'Adding tag to link' do
    visit '/links/new'
    expect(page).to have_field 'tag'
    # fill_in 'url',   with: 'http://www.google.com/'
    # fill_in 'title', with: 'Google'
    # fill_in 'tag', with: 'Search'
    # click_button 'Submit'
    # expect(current_path).to eq '/links'
    # within 'ul#links' do
    #   expect(page).to have_content('Search')
    end
    scenario 'something' do
      visit '/links/new'
      fill_in 'url',   with: 'http://www.makersacademy.com/'
      fill_in 'title', with: 'Makers Academy'
      fill_in 'tag',  with: 'education'
      click_button 'Submit'
      link = Link.first
      expect(link.tags.map(&:tag)).to include('education')
    end
  end
