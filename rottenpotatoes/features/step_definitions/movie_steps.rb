
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /(.*) seed movies should exist/ do | n_seeds |
  Movie.count.should be n_seeds.to_i
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  e1 <=> e2
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(',').each do |rating|
    field = "ratings_#{rating.strip}"
    if uncheck
      uncheck field
    else
      check field
    end
  end
end

Then /I should see all the movies/ do
  movies_shown = page.all("#movies tbody td:nth-child(1)").map { |m| m.text }
  movies_shown.count.should == Movie.count
end

Then /I should (not )?see the following movies: (.*)$/ do |present, movies_list|
  movies = movies_list.split(', ')
  movies.each do |movie|
    if present.nil?
      expect(page).to have_content(movie)
    else
      expect(page).not_to have_content(movie)
    end
  end
end

When /^I press "(.*)" button/ do |button|
  click_button button
end
