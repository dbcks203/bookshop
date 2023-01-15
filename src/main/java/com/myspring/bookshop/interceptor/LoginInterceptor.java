package com.myspring.bookshop.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	private static final Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		HttpSession session = request.getSession();
		String requestURI = request.getRequestURI();
		String[] non_required_login = { 
				"/bookshop/member/loginForm.do",
				"/bookshop/member/login.do",
				"/bookshop/member/memberForm.do",
				"/bookshop/member/addMember.do",
				"/bookshop/member/plzLogin.do",
				"/bookshop/book/bookListForm.do",
				"/bookshop/util/viewList.do",
				"/bookshop/member/overlapped.do",
				"/"
				};
		logger.info("uri:{}", requestURI);
		logger.info("isLogOn:{}", session.getAttribute("isLogOn"));
		for(String check_page: non_required_login) {
			if(check_page.equals(requestURI))
				return true;
		}
		if(null==session.getAttribute("isLogOn")||false == (Boolean)session.getAttribute("isLogOn")) {
			response.sendRedirect(request.getContextPath()+"/member/plzLogin.do");
			return false;
		}
			
		else
			return true;
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler,
			ModelAndView modelAndView) throws Exception {
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}
