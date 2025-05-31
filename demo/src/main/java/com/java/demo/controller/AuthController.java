package com.java.demo.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import com.java.demo.model.User;
import com.java.demo.repository.UserRepository;

import jakarta.servlet.http.HttpServletRequest;

@Controller
public class AuthController {
	@Autowired
    private UserRepository userRepository;
	
	@GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        return "register";
    }

    @PostMapping("/register")
    public String registerUser(User user, Model model) {
        // ตรวจสอบว่าชื่อผู้ใช้ซ้ำหรือไม่
        if (userRepository.existsByUsername(user.getUsername())) {
            model.addAttribute("error", "ชื่อผู้ใช้นี้มีอยู่แล้ว กรุณาเลือกชื่อผู้ใช้อื่น");
            return "register";
        }

        // บันทึกผู้ใช้
        userRepository.save(user);
        return "redirect:/login";
    }
	 
	 @GetMapping("/login")
	    public String showLoginForm(Model model) {
	        model.addAttribute("user", new User()); // เพิ่ม user เพื่อให้มีข้อมูลในกรณีที่เกิด error
	        return "login";
	    }

	 @PostMapping("/login")
	 public String loginUser(User user, Model model, HttpServletRequest request) {
	     // ตรวจสอบ user ในฐานข้อมูล
	     List<User> users = userRepository.findByUsername(user.getUsername());

	     if (!users.isEmpty()) {
	            User foundUser = users.get(0);
	            if (foundUser.getPassword().equals(user.getPassword())) {
	                // การเข้าสู่ระบบสำเร็จ ส่งชื่อผู้ใช้ไปยังหน้า dashboard
	                model.addAttribute("username", foundUser.getUsername());
	                
	  
	                request.getSession().setAttribute("loggedInFirstname", foundUser.getFirstname());
	                request.getSession().setAttribute("loggedInLastname", foundUser.getLastname());
	                
	             // เก็บชื่อผู้ใช้ใน session
	                request.getSession().setAttribute("loggedInUsername", foundUser.getUsername());
	                return "redirect:/dashboard";
	            }
	        }

	     // การเข้าสู่ระบบไม่สำเร็จ ใส่ข้อความผิดพลาดลงใน model
	     model.addAttribute("error", "ชื่อผู้ใช้หรือรหัสผ่านไม่ถูกต้อง");
	     return "login";
	 }

	}
