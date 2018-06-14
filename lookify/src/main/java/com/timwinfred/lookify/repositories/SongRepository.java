package com.timwinfred.lookify.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.timwinfred.lookify.models.Song;

public interface SongRepository extends CrudRepository<Song, Long>{
	List<Song> findAll();
	List<Song> findByArtistContaining(String search);
	void deleteById(Long id);
	List<Song> findTop10ByOrderByRatingDesc();
}
