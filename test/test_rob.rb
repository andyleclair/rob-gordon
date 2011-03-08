require 'helper'

class TestRob < Test::Unit::TestCase

	def setup
		@music_dir = File.expand_path(File.join('test', 'music'))
		@music_lib = File.expand_path(File.join('test', 'library'))
	end

	def test_import
		Rob::Gordon::import!(@music_dir, @music_lib)
		assert Dir.exists? File.join(@music_lib, 'Camden'), "Didin't create artist dir"
		assert Dir.exists? File.join(@music_lib, 'Camden', 'Vale'), "Didin't create album dir"
	end

	def teardown
		Dir[File.join(@music_lib, '**.mp3')].each do |file|
			FileUtils.remove_file file
		end
	end

end
