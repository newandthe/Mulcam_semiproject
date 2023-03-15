package a.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class HomeController {
	
	private static final Logger logger =LoggerFactory.getLogger(HomeController.class);

	//시작페이지 mapping변경
	@RequestMapping("/")
	public String main(Model model) {
		System.out.println("HomeController main()_msg " + new Date());
		
		model.addAttribute("msg", "홈페이지 방문을 환영합니다");
		
		return "main"; //main.jsp
	}

	//url mapping
	//기본, 루트 페이지 -> home메서드 호출
	@RequestMapping(value="home.do", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate);
		
		//home.jsp로 포워딩
		//-> servlet-context.xml
		//<bean:property name="prefix" value="/WEB-INF/views/"/>
		return "home";
	}
}
