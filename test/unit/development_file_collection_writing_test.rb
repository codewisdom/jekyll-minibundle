require 'support/test_case'
require 'support/fixture_config'
require 'jekyll/minibundle/development_file'

module Jekyll::Minibundle::Test
  class DevelopmentFileCollectionWritingTest < TestCase
    include FixtureConfig

    def test_calling_write_before_destination_path_for_markup_writes_destination
      with_fake_site do |site|
        dev_files = DevelopmentFileCollection.new(site, bundle_config)

        assert first_file_of(dev_files).write('_site')

        destination_file = destination_path(JS_BUNDLE_DESTINATION_PATH, 'dependency.js')

        assert File.exist?(destination_file)

        org_mtime = mtime_of(destination_file)
        dev_files.destination_path_for_markup

        refute first_file_of(dev_files).write('_site')
        assert_equal org_mtime, mtime_of(destination_file)
      end
    end

    private

    def bundle_config
      {
       'type'             => :js,
       'source_dir'       => JS_BUNDLE_SOURCE_DIR,
       'assets'           => %w{dependency app},
       'destination_path' => JS_BUNDLE_DESTINATION_PATH,
       'attributes'       => {}
      }
    end

    def first_file_of(dev_files)
      dev_files.instance_variable_get(:@files).first
    end
  end
end