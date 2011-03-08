require 'id3lib'

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
						
			if args.length < 1
				puts INTRO
			else
				indir, library = args
				import!(indir, library)
			end
			return 0
		end

		def self.import!(indir, libdir='~/Music')
			Dir[File.join(indir, '**.mp3')].each do |file|
				song = ID3Lib::Tag.new file
				puts "#{ song.artist }/#{ song.album }/#{ song.track } #{ song.title }.mp3"
			end
		end
	end
end
