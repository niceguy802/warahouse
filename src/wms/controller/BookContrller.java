package com.neu.wms.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.neu.wms.domain.Book;
import com.neu.wms.domain.User;
import com.neu.wms.query.BookQuery;
import com.neu.wms.query.SupplierQuery;
import com.neu.wms.service.BookService;
import com.neu.wms.service.SupplierService;
import com.neu.wms.utils.JsonModel;

@Controller
@RequestMapping("books")
public class BookContrller {
	
	@Autowired
	BookService bookService;
	
	@Autowired
	SupplierService supplierService;
	 
	/**
	 * 列表界面
	 * @return
	 */
	@RequestMapping(value="listUI",method=RequestMethod.GET)
	public String listUI() {
		return "book/list";
	}
	
	@RequestMapping(value="list",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel list(BookQuery bookQuery) {
		JsonModel jsonModel = new JsonModel();		 
		List<Book> books = bookService.findByQuery(bookQuery);		
		long count = bookService.findCount(bookQuery);
		jsonModel.setCount(count);
		jsonModel.setData(books);
		jsonModel.setSuccess(true);
		jsonModel.setMsg("查找订单成功");
		return jsonModel;
	}
	/**
	   * 添加
	 * @param model
	 * @return
	 */
	@RequestMapping(value="add",method=RequestMethod.GET)
	public String add(Model model) {		
		SupplierQuery supplierQuery = new SupplierQuery();
		model.addAttribute("suppliers", supplierService.findByQuery(supplierQuery));
		return "book/add";
	}
	 	
	@RequestMapping(value="add",method=RequestMethod.POST)
	public String add(Book book,HttpSession session) {		
		User user = (User) session.getAttribute("user");
		book.setMakeUserId(user.getId());
		bookService.add(book);
		return "redirect:/books/listUI";
	}
	/**
	   *  删除
	 * @param id
	 * @return
	 */
	@RequestMapping(value="delete",method=RequestMethod.POST)
	@ResponseBody
	public JsonModel delete(int [] id) {
		bookService.delete(id);
		JsonModel jsonModel = new JsonModel();
		jsonModel.setSuccess(true);
		jsonModel.setMsg("删除成功");
		return jsonModel;
	}
	
	/**
	 * 审核通过订单
	 * @param id
	 * @return
	 */
	@RequestMapping(value="{bookId}/status/pass",method=RequestMethod.GET)
	@ResponseBody
	public JsonModel verifyStatus(@PathVariable("bookId") int bookId) {		
		JsonModel jsonModel = new JsonModel();		
		//通过订单id查找
		Book book = bookService.findById(bookId);
		if(book.getStatus().equals((byte)0)) {
			Book tempBook = new Book();
			tempBook.setId(bookId);
			tempBook.setStatus((byte)1);
			bookService.update(tempBook);
			jsonModel.setSuccess(true);
			jsonModel.setMsg("审核成功");
		}else {
			jsonModel.setSuccess(false);
			jsonModel.setMsg("状态不对");
		}
		return jsonModel;
	}
}
