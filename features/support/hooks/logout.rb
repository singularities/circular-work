After('@logs_in') do
  @navbar_page ||= Page::Navbar.new

  @navbar_page.visit_logout
end
