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
@RequestMapping("/products")
public class ProductController {
	public final ProductService productService;
	public final CategoryService categoryService;
	
	public ProductController(ProductService productService, CategoryService categoryService) {
		this.productService = productService;
		this.categoryService = categoryService;
	}
	
	// add a product page
	@RequestMapping("/new")
	public String newProduct(@ModelAttribute Product product) {
		return "newproduct.jsp";
	}
	
	// add product POST request
	@RequestMapping(value="/new", method=RequestMethod.POST)
	public String addProduct(@Valid @ModelAttribute("product") Product product, BindingResult result) {
		if(result.hasErrors()) {
			return "newproduct.jsp";
		} else {
			productService.createProduct(product);
			return "redirect:/products/new";
		}
	}
	
	// individual product page
	@RequestMapping("/{id}")
	public String product(@PathVariable(value="id", required=true) Long id, Model model) {
		Product product = productService.getProduct(id);
		List<Category> categories = categoryService.getAllCategories();
		model.addAttribute("product", product);
		model.addAttribute("categories", categories);
		return "product.jsp";
	}
	
	// add category to product POST request
	@RequestMapping(value="/addcat/{product_id}", method=RequestMethod.POST)
	public String addCategoryToProduct(@PathVariable(value="product_id", required=true) Long product_id, @RequestParam("category_id") Long category_id) {
		productService.addCategoryToProduct(product_id, category_id);
		return "redirect:/products/" + product_id;
	}
}
