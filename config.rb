set :css_dir, 'stylesheets'
set :js_dir, 'javascripts'
set :images_dir, 'images'
set :fonts_dir,  'fonts'
set :relative_links, true

###
# Compass
###

# Change Compass configuration
# compass_config do |config|
#   config.output_style = :compact
# end

###
# Page options, layouts, aliases and proxies
###

activate :directory_indexes

activate :livereload

# Per-page layout changes:
#
# With no layout
# page "/path/to/file.html", :layout => false
#
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
#
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy pages (https://middlemanapp.com/advanced/dynamic_pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", :locals => {
#  :which_fake_page => "Rendering a fake page with a local variable" }

###
# Helpers
###

# Automatic image dimensions on image_tag helper
# activate :automatic_image_sizes

# Methods defined in the helpers block are available in templates
helpers do
  def nav_item(text, url, options={})
    content_tag(:li, class: "nav-item #{nav_class_if_active(url)}") do
      link_to text, url, class: "nav-link"
    end
  end

  def nav_class_if_active(url)
    url = url.sub(/index\.html$/, '')
    'active' if url == current_page.path.sub(/\.html$/, '')
  end

  def nav_classes_for(url)
    classes = []
    path = url.sub(/index\.html$/, '')
    current_url = current_resource.url
    classes << "on" if current_url == path
    classes << "in" if current_url.include?(path)
    classes.join(' ')
  end
end

case ENV['TARGET'].to_s.downcase
when 'staging'
  activate :deploy do |deploy|
    deploy.method   = :git
    deploy.build_before = true
    # set :http_prefix, '/siderman'
  end
else
  activate :deploy do |deploy|

  end
end

# Build-specific configuration
configure :build do
  # For example, change the Compass output style for deployment
  activate :minify_css

  # Minify Javascript on build
  activate :minify_javascript

  # Enable cache buster
  activate :asset_hash

  # Use relative URLs
  activate :relative_assets
  set :relative_links, true
end