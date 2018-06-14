package com.timwinfred.lookify.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.timwinfred.lookify.models.Song;
import com.timwinfred.lookify.services.SongService;

@Controller
public class SongController {
	public final SongService songService;

	public SongController(SongService songService) {
		this.songService = songService;
	}

	// homepage
	@RequestMapping("/")
	public String index() {
		return "index.jsp";
	}
	
	// dashboard
	@RequestMapping("/dashboard")
	public String dashboard(Model model) {
		List<Song> songs = songService.allSongs();
		model.addAttribute("songs", songs);
		return "dash.jsp";
	}
	
	// song profile
	@RequestMapping("/songs/{id}")
	public String song(@PathVariable(value="id", required=true) Long id, Model model) {
		Song song = songService.findSong(id);
		model.addAttribute("song", song);
		return "song.jsp";
	}
	
	// search results
	@RequestMapping("/search/{artist}")
	public String search(@PathVariable(value="artist", required=true) String artist, Model model) {
		List<Song> songs = songService.findByArtist(artist);
		model.addAttribute("songs", songs);
		model.addAttribute("artist", artist);
		return "search.jsp";
	}
	
	// top 10 songs
	@RequestMapping("/search/top10")
	public String topSongs(Model model) {
		List<Song> songs = songService.findTop10Songs();
		model.addAttribute("songs", songs);
		return "top.jsp";
	}
	
	// add song
	@RequestMapping("/songs/new")
	public String newSong(@ModelAttribute Song song) {
		return "newsong.jsp";
	}
	
	// BACK-END REQUEST METHODS
	
	// add song
	@RequestMapping(value="/add_song", method=RequestMethod.POST)
	public String addSong(@Valid @ModelAttribute("song") Song song, BindingResult result) {
		if(result.hasErrors()) {
			return "newsong.jsp";
		}else {
			songService.createSong(song);
			return "redirect:/dashboard";
		}
	}
	
	// delete song
	@RequestMapping("/songs/delete/{id}")
	public String deleteSong(@PathVariable(value="id", required=true) Long id) {
		songService.deleteSong(id);
		return "redirect:/dashboard";
	}
	
	// search
	@RequestMapping(value="/search", method=RequestMethod.POST)
	public String searchSong(@RequestParam(value="artist", required=true) String artist) {
		if(artist.isEmpty()) {
			return "redirect:/dashboard";
		}else {
			return "redirect:/search/"+artist;
		}
	}
}
