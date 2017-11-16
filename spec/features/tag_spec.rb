feature 'tag links' do
    scenario 'adding one tag' do
      visit '/links/new'
      fill_in 'url',   with: 'http://www.makersacademy.com/'
      fill_in 'title', with: 'Makers Academy'
      fill_in 'tag',  with: 'education'
      click_button 'Submit'
      link = Link.first
      expect(link.tags.map(&:tag)).to include('education')
    end
    scenario 'adding multiple tags' do
      visit '/links/new'
      fill_in 'url',   with: 'http://www.bbc.co.uk'
      fill_in 'title', with: 'BBC'
      fill_in 'tag',  with: 'news, sport'
      click_button 'Submit'
      link = Link.first
      expect(link.tags.map(&:tag)).to include('news', 'sport')
    end
  end
