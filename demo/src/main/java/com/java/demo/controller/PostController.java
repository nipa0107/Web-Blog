package com.java.demo.controller;

import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.java.demo.model.Comment;
import com.java.demo.model.Post;
import com.java.demo.repository.PostRepository;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import jakarta.transaction.Transactional;

@Controller
public class PostController {
	
	@Autowired PostRepository repo;
	
	
	@GetMapping("/dashboard")
    public String showPost(Model model, HttpSession session) {
        // ดึงชื่อผู้ใช้จาก session
        String loggedInUsername = (String) session.getAttribute("loggedInUsername");

        if (loggedInUsername != null) {
            List<Post> allpost = repo.kk();
            model.addAttribute("posts", allpost);
            model.addAttribute("loggedInUsername", loggedInUsername);
            
            
            return "dashboard";
        } else {
            return "redirect:/login";
        }
	}
	
	
//ไปหน้า เพิ่ม
	@GetMapping("/addpost")
	public String addpost(Model model) { 
		return "addpost";
		}
	
	@GetMapping("/addpostself")
	public String addpostself(Model model) { 
		return "addpostself";
		}

	@PostMapping("/addpost")
	public String addPost(
	        @RequestParam String detail,
	        @RequestParam String category,
	        @RequestParam(value = "love", defaultValue = "0") Integer love,
	        @RequestParam(required = false) String sourcePage,
	        HttpSession session, Model model ,HttpServletRequest request) {
	    Post post = new Post();
	    post.setCategory(category);
	    post.setDetail(detail);
	    // ดึงชื่อผู้ใช้จาก session
	    String loggedInUsername = (String) session.getAttribute("loggedInUsername");

	    if (loggedInUsername != null) {
	        post.setAuthor(loggedInUsername);
	    } else {
	        return "redirect:/login";
	    }
	    post.setTimestamp(new java.sql.Date(new java.util.Date().getTime()));
	    post.setLove(love);
	    repo.insert(post);

	    //ตรวจสอบ sourcePage
	    if ("profile".equals(sourcePage)) {
	        return "redirect:/profile";
	    } else if ("dashboard".equals(sourcePage)) {
	        return "redirect:/dashboard";
	    } else {	        
	    	return "redirect:/dashboard";
	    }
	}

	@PostMapping("/addpostself")
	public String addPostself(
	        @RequestParam String detail,
	        @RequestParam String category,
	        @RequestParam(value = "love", defaultValue = "0") Integer love,
	        @RequestParam(required = false) String sourcePage, // เพิ่มพารามิเตอร์ sourcePage
	        HttpSession session, Model model ,HttpServletRequest request) {
	    Post post = new Post();
	    post.setCategory(category);
	    post.setDetail(detail);

	    // ดึงชื่อผู้ใช้จาก session
	    String loggedInUsername = (String) session.getAttribute("loggedInUsername");

	    if (loggedInUsername != null) {
	        post.setAuthor(loggedInUsername);
	    } else {
	        return "redirect:/login";
	    }
	    post.setTimestamp(new java.sql.Date(new java.util.Date().getTime()));
	    post.setLove(love);
	    repo.insert(post);

	    if ("profile".equals(sourcePage)) {
	        return "redirect:/profile";
	    } else if ("dashboard".equals(sourcePage)) {
	        return "redirect:/dashboard";
	    } else {
	        return "redirect:/dashboard";
	    }
	}

	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
	    //ลบ session ทั้งหมดที่เกี่ยวข้องกับผู้ใช้
	    session.invalidate();
	    return "redirect:/login";
	}
	
	@GetMapping("/like/{id}")
	public String like(@PathVariable Integer id, Model model, HttpSession session, HttpServletRequest request) {
	    String loggedInUsername = (String) session.getAttribute("loggedInUsername");

	    if (loggedInUsername != null) {
	        Set<Integer> likedPostIds = repo.findLikedPostIdsByUsername(loggedInUsername);

	        if (!likedPostIds.contains(id)) {
	            Post post = repo.findById(id);
	            
	            if (post != null) {
	                if (!post.getLikedUsernames().contains(loggedInUsername)) {
	                    // ยังไม่ได้ไลค์,กดไลค์และเพิ่มIDของโพสต์เข้าไปในฐานข้อมูล
	                    post.setLove(post.getLove() + 1);
	                    post.getLikedUsernames().add(loggedInUsername);
	                    repo.save(post);
	                }
	            }
	        } else {
	            // ไลค์ไปแล้วทำการUnlike
	            repo.unlikePost(id, loggedInUsername);
	        }
	    }
//กลับไปไปหน้าที่กด
	    String referer = request.getHeader("Referer");
	    return "redirect:" + referer;
	}
	
//ค้นหาโพส
		 @GetMapping("/search")
		    public String searchPosts(@RequestParam(required = false) String keyword, 
		    		@RequestParam(required = false) String category, Model model) {
		        List<Post> allPosts;
		        
		        if ((keyword != null && !keyword.isEmpty()) || (category != null && !category.isEmpty())) {
			         allPosts = repo.searchPosts(keyword, category);
			     } else {
			         allPosts = repo.kk();
			     }

		        model.addAttribute("posts", allPosts);
		        model.addAttribute("keyword", keyword);
		        
		        
		        return "dashboard";
		        
		        
		    }


		 //แก้ไขโพส
		// แสดงหน้าฟอร์มแก้ไขโพสท์
		 @GetMapping("/editpost/{id}")
		 public String editPostForm(@PathVariable Integer id, Model model, HttpSession session) {
		     Post post = repo.findById(id);

		     if (post != null && isLoggedInUserAuthor(session, post.getAuthor())) {
		         model.addAttribute("post", post);
		         return "editpost";
		     } else {
		         return "redirect:/dashboard";
		     }
		 }

		 @PostMapping("/editpost/{id}")
		 public String editPost(@PathVariable Integer id, @RequestParam String detail, HttpSession session) {
		     Post post = repo.findById(id);

		     if (post != null && isLoggedInUserAuthor(session, post.getAuthor())) {
		         post.setDetail(detail);
		         repo.save(post);
		         return "redirect:/dashboard";
		     } else {
		         return "redirect:/dashboard";
		     }
		 }
		 
		 @GetMapping("/editpostself/{id}")
		 public String editPostselfForm(@PathVariable Integer id, Model model, HttpSession session) {
		     Post post = repo.findById(id);

		     if (post != null && isLoggedInUserAuthor(session, post.getAuthor())) {
		         model.addAttribute("post", post);
		         return "editpostself";
		     } else {
		         return "redirect:/dashboard";
		     }
		 }

		 @PostMapping("/editpostself/{id}")
		 public String editPostself(@PathVariable Integer id, @RequestParam String detail, HttpSession session) {
		     Post post = repo.findById(id);

		     if (post != null && isLoggedInUserAuthor(session, post.getAuthor())) {
		         post.setDetail(detail);
		         repo.save(post);
		         return "redirect:/dashboard";
		     } else {
		         return "redirect:/dashboard";
		     }
		 }

		 @GetMapping("/delete/{id}")
		 public String deletePost(@PathVariable Integer id, HttpSession session,HttpServletRequest request) {
		     Post post = repo.findById(id);
		     String referer = request.getHeader("Referer");
		     if (post != null && isLoggedInUserAuthor(session, post.getAuthor())) {
		         repo.deleteById(id);
		        
		 	    return "redirect:" + referer;
		     } else {		 	
		 	    return "redirect:" + referer;
		     }
		 }
		 private boolean isLoggedInUserAuthor(HttpSession session, String postAuthor) {
		     String loggedInUsername = (String) session.getAttribute("loggedInUsername");
		     return loggedInUsername != null && loggedInUsername.equals(postAuthor);
		 }


//คอมเม้นต์
		 @Transactional
		    @PostMapping("/addComment")
		    public String addComment(
		            @RequestParam Integer postId,
		            @RequestParam String comment,
		            HttpSession session
		    ) {
		        String loggedInUsername = (String) session.getAttribute("loggedInUsername");
		        repo.addComment(postId, loggedInUsername, comment);
		        return "redirect:/dashboard";
		    }
		 
//โปรไฟล์ 
		 @GetMapping("/profile")
		 public String showProfile(Model model, HttpSession session) {
		     // ดึงชื่อผู้ใช้จาก session
		     String loggedInUsername = (String) session.getAttribute("loggedInUsername");

		     if (loggedInUsername != null) {
		         List<Post> userPosts = repo.findByAuthor(loggedInUsername);
		         model.addAttribute("posts", userPosts);
		         model.addAttribute("loggedInUsername", loggedInUsername);
		         return "profile";
		     } else {
		         return "redirect:/login";
		     }
		 }
		 
		 
		 

}