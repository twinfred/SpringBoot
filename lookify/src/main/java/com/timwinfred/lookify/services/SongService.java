package com.timwinfred.lookify.services;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.timwinfred.lookify.models.Song;
import com.timwinfred.lookify.repositories.SongRepository;

@Service
public class SongService {
	private final SongRepository songRepository;

	public SongService(SongRepository songRepository) {
		this.songRepository = songRepository;
	}
	
	// returns all songs
	public List<Song> allSongs() {
		return songRepository.findAll();
	}
	
	// create a song
	public Song createSong(Song song) {
		return songRepository.save(song);
	}
	
	// get a single song
	public Song findSong(Long id) {
		Optional<Song> optionalSong = songRepository.findById(id);
		if(optionalSong.isPresent()) {
			return optionalSong.get();
		} else {
			return null;
		}
	}
	
	// get the top 10 songs
	public List<Song> findTop10Songs() {
		return songRepository.findTop10ByOrderByRatingDesc();
	}
	
	// search for songs by a specific artist
	public List<Song> findByArtist(String artist) {
		return songRepository.findByArtistContaining(artist);
	}
	
	// delete a song
	public void deleteSong(Long id) {
		Optional<Song> optionalSong = songRepository.findById(id);
		if(optionalSong.isPresent()) {
			songRepository.deleteById(id);
			return;
		} else {
			return;
		}
	}
}
