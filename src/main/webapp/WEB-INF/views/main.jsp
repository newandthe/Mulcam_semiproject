<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css" integrity="sha384-Vkoo8x4CGsO3+Hhxv8T/Q5PaXtkKtu6ug5TOeNV6gBiFeWPGFN9MuhOf23Q9Ifjh" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<title>mulcam.SemiProj_Pet MainPage</title>

<!-- GOOGLE FONTS LINK -->
<link rel="preconnect" href="https://fonts.gstatic.com">
<link href="https://fonts.googleapis.com/css2?family=Lobster&display=swap" rel="stylesheet">
</head>
<body>
<!-- Header -->
 <nav class="navbar navbar-light bg-light" style="background-color: #e3f2fd;">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">
      <img src="./Resources/animalFoot.png" alt="" width="30" height="24" class="d-inline-block align-text-bottom">
      <h1 style="font-family: 'Lobster', cursive">Mypet Community</h1>
    </a>
 
<form class="d-flex">
      <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search">
      <button class="btn btn-outline-success" type="submit" style="font-family: 'Lobster', cursive">Search</button>
    </form>
    
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
  <div class="container-fluid">
    <a class="navbar-brand" href="#" style="font-family: 'Lobster', cursive">Main Page</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarNavDropdown">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link active" aria-current="page" href="#" style="font-family: 'Lobster', cursive">Board</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#" style="font-family: 'Lobster', cursive">Q&A</a>
        </li>
        
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="myPage.do" id="navbarDropdownMenuLink" role="button" data-bs-toggle="dropdown" aria-expanded="false"
          style="font-family: 'Lobster', cursive">
            MyPage
          </a>
          <ul class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
            <li><a class="dropdown-item" href="#">...</a></li>
            <li><a class="dropdown-item" href="#">나의 일정 관리</a></li>
            <li><a class="dropdown-item" href="#">로그아웃</a></li>
          </ul>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#admin_login.do" style="font-family: 'Lobster', cursive">admin page</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#" style="font-family: 'Lobster', cursive">login</a>
        </li>
      </ul>
    </div>
  </div>
</nav>
</div>
</nav>

footer
<footer class="bg-light text-center text-white">
  Grid container
  <div class="container p-4 pb-0">
  </div>
  Grid container

  Copyright
  <div class="text-center p-3" style="background-color: rgba(0, 0, 0, 0.2);">
    © 2023 Copyright:
    <a class="text-white" href="https://mdbootstrap.com/">Love pet</a>
  </div>
  Copyright
</footer>
<!-- footer 끝   -->
</body>
</html>