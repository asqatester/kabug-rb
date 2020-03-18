# frozen_string_literal: true

Before do
  # page.current_window.resize_to(1920, 1080)
  page.current_window.resize_to(1440, 900)
  visit '/'
end

After do |scenario|
  screenshot = page.save_screenshot("logs/screenshots/#{scenario.__id__}.png")
  embed(screenshot, 'image/png', 'Screenshot')
end
