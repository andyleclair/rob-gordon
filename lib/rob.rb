require 'id3lib'
require 'fileutils'
require 'iconv'

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
			Dir[File.join(indir, '**.mp3')].sort.each do |file|
				if File.extname(file) == '.mp3'
					song = ID3Lib::Tag.new file
					begin
						artist =  song.artist
						album  =  song.album
						track	 =  song.track[0]
						title  =  song.title
						out_file = filename(song.track, song.title)
						dest = File.join(libdir, song.artist, song.album, out_file)
						artistdir = File.join(libdir, song.artist)
						albumdir = File.join(artistdir, song.album)
					rescue 
						# Suck a dick, UTF-16
						artist = Iconv.conv('UTF-8', 'UTF-16BE', song.artist)
						album  = Iconv.conv('UTF-8', 'UTF-16BE', song.album)
						track	 = Iconv.conv('UTF-8', 'UTF-16BE', song.track)[0]
						title  = Iconv.conv('UTF-8', 'UTF-16BE', song.title) 
						out_file = filename(track, title)
						dest = File.join(libdir, artist, album, out_file)
						artistdir = File.join(libdir, artist)
						albumdir = File.join(artistdir, album)
					end
					if !File.exists? dest
						if !Dir.exists? artistdir
							puts "Creating artist directory #{ artistdir }"
							Dir.mkdir artistdir
						end

						if !Dir.exists? albumdir
							puts "Creating album directory #{ albumdir }"
							Dir.mkdir albumdir
						end
						
						puts "Now importing #{ title } to #{ dest }"
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
