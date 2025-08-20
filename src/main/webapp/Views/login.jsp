<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Pahana Edu - Login</title>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap');
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }
        
        body {
         
        background: 
        linear-gradient(rgba(0, 0, 0, 0.5), rgba(0, 0, 0, 0.5)),
        url('${pageContext.request.contextPath}/images/1.png');
    background-size: cover;
    background-position: center;
    background-repeat: no-repeat;
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
        }
          .welcome-header {
            text-align: center;
            color: black;
            margin-bottom: 30px;
            font-weight: 500;
            text-shadow: 1px 1px 3px rgba(0, 0, 0, 0.3);
            font-size: 1.0rem;
        }
        .login-container {
            width: 380px;
            background: rgba(255, 255, 255, 0.95);
            border-radius: 15px;
            box-shadow: 0 15px 35px rgba(0, 0, 0, 0.2);
            overflow: hidden;
            transition: transform 0.3s ease;
            backdrop-filter: blur(5px);
        }
        
        .login-container:hover {
            transform: translateY(-5px);
        }
        
        .logo-area {
            background: rgba(248, 249, 250, 0.8);
            padding: 30px 0;
            text-align: center;
            border-bottom: 1px solid rgba(0, 0, 0, 0.1);
        }
        
        .logo-placeholder {
            width: 80px;
            height: 80px;
            margin: 0 auto 15px;
            background: #e9ecef;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: #6c757d;
            font-size: 24px;
            font-weight: bold;
        }
        
        .form-area {
            padding: 30px;
        }
        
        h2 {
            text-align: center;
            margin-bottom: 25px;
            color: #343a40;
            font-weight: 600;
        }
        
        .input-group {
            margin-bottom: 20px;
            position: relative;
        }
        
        .input-group input {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e9ecef;
            border-radius: 8px;
            font-size: 14px;
            transition: all 0.3s;
            background: rgba(255, 255, 255, 0.8);
        }
        
        .input-group input:focus {
            border-color: #667eea;
            outline: none;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
            background: white;
        }
        
        .input-group label {
            position: absolute;
            top: -10px;
            left: 10px;
            background: white;
            padding: 0 5px;
            font-size: 12px;
            color: #6c757d;
        }
        
        .btn-login {
            width: 100%;
            padding: 12px;
            background: linear-gradient(to right, #667eea, #764ba2);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s;
        }
        
        .btn-login:hover {
            background: linear-gradient(to right, #5a6fd1, #6a4299);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .error-message {
            color: #dc3545;
            text-align: center;
            margin-bottom: 20px;
            font-size: 14px;
        }
        
        .footer-links {
            text-align: center;
            margin-top: 20px;
            font-size: 13px;
        }
        
        .footer-links a {
            color: #6c757d;
            text-decoration: none;
            transition: color 0.3s;
        }
        
        .footer-links a:hover {
            color: #667eea;
        }
        .logo-image {
    width: 80px;
    height: 80px;
    margin: 0 auto 15px;
    border-radius: 50%; /* This makes the image round */
    object-fit: cover; /* Ensures the image fills the circle without distortion */
    display: block; /* Centers the image */
    padding: 5px; /* Optional: adds some spacing between image and border */
    border: 2px solid #6c757d; /* Optional: adds a border like your placeholder */
}
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-area">
          <div class="logo-image-container">
        <img src="${pageContext.request.contextPath}/images/10.png" alt="Pahana Edu Logo" 
             onerror="this.onerror=null; this.src='placeholder.jpg'"
             class="logo-image">
    </div>
           
             <div class="welcome-header">
             <h2>PAHANA EDU</h2>
        <h5>Welcome to largest bookstore in Sri Lanka</h5>
    </div>
        </div>
        
        <div class="form-area">
            <% if (request.getAttribute("error") != null) { %>
                <div class="error-message"><%= request.getAttribute("error") %></div>
            <% } %>
            
          <form action="${pageContext.request.contextPath}/AuthServlet" method="post">

                <div class="input-group">
                    <label for="username">Username</label>
                    <input type="text" id="username" name="username" placeholder="Username" required>
                </div>
                
                <div class="input-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Password" required>
                </div>
                
                <button type="submit" class="btn-login">Login</button>
            </form>
            
    
        </div>
    </div>
</body>
</html>