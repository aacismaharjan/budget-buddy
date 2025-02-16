package com.budgetbuddy;

import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import jakarta.servlet.*;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SessionFilter implements Filter {
		private List<String> includedUrls;
		
		@Override
		public void init(FilterConfig filterConfig) throws ServletException {
			// Initialize excluded URLs list from filter configuration
			String includedUrlsStr = filterConfig.getInitParameter("includedUrls");
			includedUrls = Arrays.asList(includedUrlsStr.split("\\s*, \\s*"));
		}
		
		@Override
		public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
				HttpServletRequest httpRequest = (HttpServletRequest) request;
				HttpServletResponse httpResponse = (HttpServletResponse) response;
				
				String requestURI = httpRequest.getRequestURI();
				
				
				// Check if the request URI is in the excluded URls list
				if(includedUrls.contains(requestURI)) {
					// Session verification logic
					String user = (String) httpRequest.getSession().getAttribute("user");
					
					if(user == null) {
						httpResponse.sendRedirect("login.jsp");
						return ;
					}
				}
				
				// Continue with the filter chain
				chain.doFilter(request, response);
		}
		
		@Override
		public void destroy() {
			// Cleanup code, if needed
		}
		
		
}