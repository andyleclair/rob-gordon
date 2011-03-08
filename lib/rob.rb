require 'id3lib'
require 'fileutils'

module Rob
	module Gordon

		INTRO = %{
	"What came first, the music or the misery? People worry about kids playing with guns, or watching violent videos, that some sort of culture of violence will take them over. 
	Nobody worries about kids listening to thousands, literally thousands of songs about heartbreak, rejection, pain, misery and loss. 
	Did I listen to pop music because I was miserable? Or was I miserable because I listened to pop music?"

	usage:
	rob %folder %library

	That command will import the folder to your library
}


		def self.run!(*args)
						
			case args.length
			when 0
				puts INTRO
			when 1
				indir = args[0]
				import!(indir)
			when 2
				indir, lib = args
				import!(indir, lib)
			else
				puts INTRO
			end
			return 0
		end

		def self.import!(indir, libdir="#{ ENV['HOME']}/Music")
			puts "Imporing all mp3s in: #{ indir }"
			puts "Now importing to #{ libdir }"
			Dir[File.join(indir, '**.mp3')].each do |file|
				if File.extname(file) == '.mp3'
					song = ID3Lib::Tag.new file
					dest = File.join(libdir, song.artist, song.album, filename(song.track, song.title))
					if !File.exists? dest
						artistdir = File.join(libdir, song.artist)
						if !Dir.exists? artistdir
							puts "Creating artist directory #{ artistdir }"
							Dir.mkdir artistdir
						end

						albumdir = File.join(artistdir, song.album)

						if !Dir.exists? albumdir
							puts "Creating album directory #{ albumdir }"
							Dir.mkdir albumdir
						end
						
						puts "Now importing #{ song.track } to #{ libdir }"
						FileUtils.cp file, dest
					else
						puts "Destination file #{ dest } exists, skipping..."
					end
				else

				end
			end
		end

		def self.filename(track, title)
			if track.to_i < 10
				"0#{ track }. #{ title }.mp3"
			else
				"#{ track }. #{ title }.mp3"
			end
		end
	end
end
