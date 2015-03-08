activate :directory_indexes

issues = { 1 => 'Pilot', 2 => 'The Other Woman', 3 => 'The Wicked Stepsister', 4 => 'The Dame in Fur', 5 => '25 Lies', 6 => 'Nature', 7 => 'Sanctuary', 8 => 'Chasing Rabbits', 9 => 'Bling', 10 => 'Nurture' }
comics = ['01pg01.gif', '01pg02.gif', '01pg03.png', '01pg04.png', '01pg05.png', '01pg06.png', '01pg07.png', '01pg08.png', '01pg09.png', '01pg10.png', '01pg11.gif', '01pg12.gif', '01pg13.gif', '01pg14.gif', '01pg15.gif', '01pg16.gif', '01pg17.gif', '01pg18.gif', '01pg19.gif', '01pg20.gif', '01pg21.gif', '01pg22.gif', '01pg23.gif', '01pg24.gif', '01pg25.gif', '01pg26.gif', '01pg27.gif', '01pg28.gif', '01pg29.gif', '01pg30.gif', '01pg31.gif', '01pg32.gif', '01pg33.gif', '01pg34.gif', '01pg35.gif', '02pg01.gif', '02pg02.gif', '02pg03.gif', '02pg04.gif', '02pg05.gif', '02pg06.gif', '02pg07.gif', '02pg08.gif', '02pg09.gif', '02pg10.gif', '02pg11.gif', '02pg12.gif', '02pg13.gif', '02pg14.gif', '02pg15.gif', '02pg16.gif', '02pg17.gif', '02pg18.gif', '02pg19.gif', '02pg20.gif', '02pg21.gif', '02pg22.gif', '02pg23.gif', '02pg24.gif', '02pg25.gif', '03pg01.gif', '03pg02.gif', '03pg03.gif', '03pg04.gif', '03pg05.gif', '03pg06.gif', '03pg07.gif', '03pg08.gif', '03pg09.gif', '03pg10.gif', '03pg11.gif', '03pg12.gif', '03pg13.gif', '03pg14.gif', '03pg15.gif', '03pg16.gif', '03pg17.gif', '03pg18.gif', '03pg19.gif', '03pg20.gif', '03pg21.gif', '03pg22.gif', '03pg23.gif', '03pg24.gif', '03pg25.gif', '03pg26.gif', '03pg27.gif', '04pg01.gif', '04pg02.gif', '04pg03.gif', '04pg04.png', '04pg05.png', '04pg06.png', '04pg07.gif', '04pg08.gif', '04pg09.gif', '04pg10.gif', '04pg11.gif', '04pg12.gif', '04pg13.gif', '04pg14.gif', '04pg15.gif', '04pg16.gif', '04pg17.gif', '04pg18.gif', '04pg19.gif', '04pg20.gif', '04pg21.gif', '04pg22.gif', '04pg23.gif', '04pg24.gif', '04pg25.gif', '04pg26.gif', '04pg27.png', '05pg01.gif', '05pg02.gif', '05pg03.gif', '05pg04.gif', '05pg05.gif', '05pg06.gif', '05pg07.gif', '05pg08.gif', '05pg09.gif', '05pg10.gif', '05pg11.gif', '05pg12.gif', '05pg13.gif', '05pg14.gif', '05pg15.gif', '05pg16.gif', '05pg17.gif', '05pg18.gif', '05pg19.gif', '05pg20.gif', '05pg21.gif', '05pg22.gif', '05pg23.gif', '05pg24.gif', '05pg25.gif', '05pg26.gif', '05pg27.gif', '05pg28.gif', '05pg29.gif', '05pg30.gif', '06pg01.gif', '06pg02.gif', '06pg03.gif', '06pg04.gif', '06pg05.gif', '06pg06.gif', '06pg07.gif', '06pg08.gif', '06pg09.gif', '06pg10.gif', '06pg11.gif', '06pg12.gif', '06pg13.gif', '06pg14.gif', '06pg15.gif', '06pg16.gif', '06pg17.gif', '06pg18.gif', '06pg19.gif', '06pg20.gif', '06pg21.gif', '06pg22.gif', '06pg23.gif', '06pg24.gif', '06pg25.gif', '06pg26.gif', '06pg27.gif', '06pg28.gif', '06pg29.gif', '06pg30.gif', '06pg31.gif', '06pg32.gif', '07pg01.gif', '07pg02.gif', '07pg03.gif', '07pg04.gif', '07pg05.gif', '07pg06.gif', '07pg07.gif', '07pg08.gif', '07pg09.png', '07pg10.png', '07pg11.gif', '07pg12.gif', '07pg13.gif', '07pg14.gif', '07pg15.gif', '07pg16.gif', '07pg17.gif', '07pg18.gif', '07pg19.gif', '07pg20.gif', '07pg21.gif', '07pg22.gif', '07pg23.gif', '07pg24.gif', '07pg25.gif', '07pg26.gif', '07pg27.gif', '07pg28.gif', '07pg29.gif', '07pg30.gif', '07pg31.gif', '07pg32.gif', '07pg33.gif', '07pg34.gif', '07pg35.gif', '08pg01.gif', '08pg02.gif', '08pg03.gif', '08pg04.gif', '08pg05.gif', '08pg06.gif', '08pg07.gif', '08pg08.gif']

comics.each_with_index do |comic_image, index|
  comic = comic_image.match(/^(?<issue>\d{2})pg(?<page>\d{2})\.(?<extension>png|gif)$/)

  next_comic = comic_image == comics.last  ? nil : comics[index + 1].match(/^(?<issue>\d{2})pg(?<page>\d{2})/)
  prev_comic = comic_image == comics.first ? nil : comics[index - 1].match(/^(?<issue>\d{2})pg(?<page>\d{2})/)

  proxy "/comic/issue-#{comic[:issue].to_i}/page-#{comic[:page].to_i}.html", '/comic_template.html', locals: {
    image: comic,
    issue: issues[comic[:issue].to_i],
    page:  comic[:page].to_i,
    next_comic: next_comic,
    prev_comic: prev_comic,
  }
end

proxy "/comic/issue-1/cover.html", 'comic_template.html', locals: {
  image: 'cover01.png',
  issue: issues[1],
  page: 'cover',
  next_comic: { issue: 1, page: 1 },
  prev_comic: nil,
}

ignore '/comic_template.html'

set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'

configure :build do
  activate :minify_css
end

activate :deploy do |deploy|
  deploy.method = :git
  deploy.build_before = true
end
