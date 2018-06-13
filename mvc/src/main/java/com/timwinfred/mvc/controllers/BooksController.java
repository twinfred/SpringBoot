package com.timwinfred.mvc.controllers;

import java.util.List;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.timwinfred.mvc.models.Book;
import com.timwinfred.mvc.services.BookService;

@Controller
public class BooksController {
	public final BookService bookService;
	
	public BooksController(BookService bookService) {
		this.bookService = bookService;
	}
	
	@RequestMapping("/books")
	public String index(Model model) {
		List<Book> books = bookService.allBooks();
		model.addAttribute("books", books);
		return "index.jsp";
	}
	
	@RequestMapping("/books/new")
	public String newBook(@ModelAttribute("book") Book book) {
		return "new.jsp";
	}
	
	@RequestMapping(value="/books", method=RequestMethod.POST)
	public String create(@Valid @ModelAttribute("book") Book book, BindingResult result) {
		if(result.hasErrors()) {
			return "new.jsp";
		}else {
			bookService.createBook(book);
			return "redirect:/books";
		}
	}
	
	@RequestMapping("/books/{id}")
	public String book(@PathVariable(value="id", required=true) Long id, Model model) {
		Book book = bookService.findBook(id);
		model.addAttribute("book", book);
		return "book.jsp";
	}
	
	@RequestMapping("/books/{id}/delete")
	public String delete(@PathVariable(value="id", required=true) Long id) {
		bookService.deleteBook(id);
		return "redirect:/books";
	}
	
}
