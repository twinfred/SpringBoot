package com.timwinfred.licenses.controllers;

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

import com.timwinfred.licenses.models.Category;
import com.timwinfred.licenses.models.Product;
import com.timwinfred.licenses.services.CategoryService;
import com.timwinfred.licenses.services.ProductService;

@Controller
@RequestMapping("/categories")
public class CategoryController {
	public final ProductService productService;
	public final CategoryService categoryService;
	
	public CategoryController(ProductService productService, CategoryService categoryService) {
		this.productService = productService;
		this.categoryService = categoryService;
	}

	// add a category page
	@RequestMapping("/new")
	public String newCategory(@ModelAttribute Category category) {
		return "newcategory.jsp";
	}
	
	// add category POST request
	@RequestMapping(value="/new", method=RequestMethod.POST)
	public String addCategory(@Valid @ModelAttribute("category") Category category, BindingResult result) {
		if(result.hasErrors()) {
			return "newcategory.jsp";
		} else {
			categoryService.createCategory(category);
			return "redirect:/categories/new";
		}
	}
	
	// individual category page
	@RequestMapping("/{id}")
	public String category(@PathVariable(value="id", required=true) Long id, Model model) {
		Category category = categoryService.getCategory(id);
		List<Product> products = productService.getAllProducts();
		model.addAttribute("category", category);
		model.addAttribute("products", products);
		return "category.jsp";
	}
	
	// add product to category POST request
	@RequestMapping(value="/addprod/{category_id}", method=RequestMethod.POST)
	public String addProductToCategory(@PathVariable(value="category_id", required=true) Long category_id, @RequestParam("product_id") Long product_id) {
		categoryService.addProductToCategory(category_id, product_id);
		return "redirect:/categories/" + category_id;
	}
}
