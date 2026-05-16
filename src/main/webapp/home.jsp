<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, com.occasiodesign.model.EventType" %>
<%
    /**
     * home.jsp - Main home/landing page of OccasioDesign.
     */

    String role = (String) session.getAttribute("role");
    String fullName = (String) session.getAttribute("fullName");
    boolean isLoggedIn = (role != null);
    boolean isAdmin = "admin".equals(role);
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>OccasioDesign - Your Perfect Event</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css"/>
    <style>
        /* --- HOME PAGE EXTRA STYLES --- */

        /* Theme preview strip */
        .theme-strip { background: #F5EBE5; padding: 28px 0; }
        .theme-strip-inner { max-width: 1100px; margin: 0 auto; padding: 0 24px; }
        .theme-strip h2 { color: var(--brown-dark); margin-bottom: 8px; font-size: 1.75rem; font-weight: 700; }
        .theme-images { display: flex; gap: 12px; overflow-x: auto; padding: 8px 0; }
        .theme-img-card {
            min-width: 190px; border-radius: 12px; overflow: hidden;
            box-shadow: 0 4px 12px rgba(107,58,42,0.15); transition: transform 0.25s; cursor: pointer;
        }
        .theme-img-card:hover { transform: scale(1.04); }
        .theme-img-card img { width: 190px; height: 130px; object-fit: cover; display: block; }
        .theme-img-caption { background: var(--brown-dark); color: rgb(62, 116, 12); font-size: 0.78rem; padding: 6px 10px; text-align: center; }

        /* Event cards section */
        .events-section { max-width: 1100px; margin: 0 auto; padding: 50px 24px 60px; }
        .events-section h2 { color: var(--brown-dark); margin-bottom: 8px; font-size: 1.5rem; font-weight: 600; }
        .section-sub { color: var(--text-light); margin-bottom: 28px; font-size: 1rem; }
        .event-card {
            background: white; border-radius: 14px; overflow: hidden;
            box-shadow: 0 4px 16px rgba(74,44,23,0.12); flex: 1 1 240px;
            transition: transform 0.25s, box-shadow 0.25s; display: flex; flex-direction: column;
        }
        .event-card:hover { transform: translateY(-5px); box-shadow: 0 8px 28px rgba(74,44,23,0.2); }
        .event-card img { width: 100%; height: 160px; object-fit: cover; display: block; }
        .event-card-body { padding: 18px; flex: 1; display: flex; flex-direction: column; }
        .event-card-body h3 { color: var(--brown-dark); margin-bottom: 6px; font-size: 1.05rem; }
        .event-card-body p { color: var(--text-light); font-size: 0.87rem; flex: 1; line-height: 1.5; }
        .event-card-body .price { color: var(--brown-mid); font-weight: 700; margin: 10px 0; font-size: 0.95rem; }
        .book-btn {
            display: block; text-align: center; padding: 10px;
            background: var(--brown-mid); color: white; text-decoration: none;
            border-radius: 8px; font-size: 0.9rem; font-weight: 600; transition: background 0.2s;
        }

        /* --- WISHLIST BUTTON (on event cards) --- */
        .wishlist-btn {
            display: block; width: 100%; margin-top: 8px; padding: 10px;
            background: white; color: #1a4a3a;
            border: 2px solid #1a4a3a;
            border-radius: 8px; cursor: pointer;
            font-size: 0.9rem; font-weight: 600;
            transition: background 0.2s, color 0.2s;
        }
        .wishlist-btn:hover { background: #1a4a3a; color: white; }

        /* --- OVERLAY BACKGROUND (used by both popups) --- */
        .popup-overlay {
            display: none;
            position: fixed; top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.6);
            z-index: 999;
            justify-content: center;
            align-items: center;
        }

        /* --- POPUP BOX (white card that appears on screen) --- */
        .popup-box {
            background: white;
            max-width: 520px; width: 90%;
            border-radius: 16px;
            padding: 32px;
            position: relative;
            max-height: 85vh;
            overflow-y: auto;
            box-shadow: 0 12px 40px rgba(0,0,0,0.25);
        }

        .popup-box h2 {
            color: #1a4a3a;
            margin-bottom: 16px;
            font-size: 1.4rem;
        }

        /* --- THEME INFO POPUP --- */
        #themeInfoImage {
            width: 100%; height: 200px;
            object-fit: cover;
            border-radius: 10px;
            margin-bottom: 16px;
        }
        #themeInfoDesc {
            color: #555;
            line-height: 1.8;
            font-size: 0.97rem;
            margin-bottom: 24px;
        }

        /* --- WISHLIST POPUP --- */
        .wishlist-item {
            border: 1px solid #e0e0e0;
            border-radius: 10px;
            padding: 14px 16px;
            margin-bottom: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .wishlist-item-name { color: #1a4a3a; font-weight: 600; font-size: 0.97rem; }
        .wishlist-item-price { color: #888; font-size: 0.87rem; margin-top: 3px; }
        .wishlist-empty { color: #999; text-align: center; padding: 20px 0; font-size: 0.95rem; }

        /* --- BACK BUTTON (inside popups) --- */
        .back-btn {
            background: #1a4a3a; color: white;
            border: none; padding: 10px 24px;
            border-radius: 8px; cursor: pointer;
            font-size: 0.95rem; font-weight: 600;
            transition: background 0.2s;
        }
        .back-btn:hover { background: #2d6e56; }

        /* --- THANK YOU TOAST (appears at top of screen for 2.5 sec) --- */
        #thankYouToast {
            display: none;
            position: fixed;
            top: 80px; left: 50%;
            transform: translateX(-50%);
            background: #1a4a3a;
            color: white;
            padding: 14px 32px;
            border-radius: 50px;
            z-index: 9999;
            font-size: 0.97rem;
            font-weight: 600;
            box-shadow: 0 8px 24px rgba(0,0,0,0.3);
            white-space: nowrap;
        }

        /* --- MY WISHLIST NAV LINK --- */
        .wishlist-nav-link {
            color: #c9a84c !important;
            font-weight: 600;
        }
        .wishlist-nav-link:hover { color: white !important; }
    </style>
</head>
<body>

<!-- ============ NAVIGATION BAR ============ -->
<nav>
    <a class="logo" href="${pageContext.request.contextPath}/home">✦ OccasioDesign</a>
    <div class="nav-links">
        <h3><a href="${pageContext.request.contextPath}/home">Home</a></h3>
        <h3><a href="${pageContext.request.contextPath}/about">About</a></h3>
        <h3><a href="${pageContext.request.contextPath}/contact">Contact</a></h3>
        <%
            if (isLoggedIn) {
                if (isAdmin) {
        %>
            <h3><a href="${pageContext.request.contextPath}/adminDashboard">Admin Panel</a></h3>
            <h3><a href="${pageContext.request.contextPath}/logout">Logout</a></h3>
        <%  } else { %>
            <h3><a href="${pageContext.request.contextPath}/userDashboard">My Dashboard</a></h3>
            <h3><a href="${pageContext.request.contextPath}/booking" class="btn-nav">Book Event</a></h3>

            <%-- ★ NEW: My Wishlist link — only for regular logged-in users --%>
            <h3><a href="#" class="wishlist-nav-link" onclick="showWishlist(); return false;">♡ My Wishlist</a></h3>

            <h3><a href="${pageContext.request.contextPath}/logout">Logout</a></h3>
        <%  } } else { %>
            <h3><a href="${pageContext.request.contextPath}/login">Login</a></h3>
            <h3><a href="${pageContext.request.contextPath}/register" class="btn-nav">Register</a></h3>
        <% } %>
    </div>
</nav>

<!-- ============ HERO SECTION ============ -->
<div class="hero">
    <h1>Your Perfect Event,<br>Beautifully Designed</h1>
    <p>Professional decoration services for every occasion in Nepal — birthdays, weddings, festivals & more</p>
    <div class="hero-buttons">
        <% if (!isLoggedIn) { %>
        <a href="${pageContext.request.contextPath}/register" class="btn-hero-primary">Book Your Event →</a>
        <a href="${pageContext.request.contextPath}/about" class="btn-hero-secondary">Learn More</a>
        <% } else if (!isAdmin) { %>
        <a href="${pageContext.request.contextPath}/booking" class="btn-hero-primary">Book New Event →</a>
        <a href="${pageContext.request.contextPath}/userDashboard" class="btn-hero-secondary">My Bookings</a>
        <% } else { %>
        <a href="${pageContext.request.contextPath}/adminDashboard" class="btn-hero-primary">Admin Dashboard →</a>
        <% } %>
    </div>
</div>

<!-- ============ THEME PREVIEW STRIP ============ -->
<%--
    ★ NEW: Each theme card now has onclick="showThemeInfo(...)"
    When user clicks a card, a popup opens with the theme name, image, and description.
    The 3 values inside showThemeInfo() are:
      1. Theme name (shown as title in popup)
      2. Image filename (from /images/themes/ folder)
      3. Description (shown as text in popup)
--%>
<div class="theme-strip">
    <div class="theme-strip-inner">
        <h2>Our Decoration Themes</h2>
        <div class="theme-images">

            <div class="theme-img-card"
                 onclick="showThemeInfo(
                     'Enchanted Garden',
                     'Enchanted_Garden',
                     'A magical garden theme filled with fairy lights, flower arches, and pastel balloons. Perfect for birthday parties and kids events. We use fresh flowers, silk drapes, and colorful decorations to make your event feel like a fairy tale straight from Nepal\'s beautiful nature.')">
                <img src="${pageContext.request.contextPath}/images/themes/Enchanted_Garden.jpg" alt="Birthday"/>
                <div class="theme-img-caption">Enchanted Garden</div>
            </div>

            <div class="theme-img-card"
                 onclick="showThemeInfo(
                     'Royal Nepali Wedding',
                     'Royal_Nepali_Wedding',
                     'An elegant golden wedding theme inspired by traditional Nepali culture. Features marigold garlands, golden drapes, warm-lit mandap decorations, and rich red and gold color palette. Perfect for weddings and anniversary celebrations that honor our beautiful heritage.')">
                <img src="${pageContext.request.contextPath}/images/themes/Royal_Nepali_Wedding.jpg" alt="Anniversary"/>
                <div class="theme-img-caption">Royal Nepali Wedding</div>
            </div>

            <div class="theme-img-card"
                 onclick="showThemeInfo(
                     'Elegant Proposal',
                     'Elegant_Proposal',
                     'A romantic and intimate engagement setup with rose petals, candle arrangements, and soft fairy lights. Perfect for proposals and engagement ceremonies. We create a dreamy atmosphere that makes this precious moment unforgettable for you and your loved one.')">
                <img src="${pageContext.request.contextPath}/images/themes/Elegant_Proposal.jpg" alt="Engagement"/>
                <div class="theme-img-caption">Elegant Proposal</div>
            </div>

            <div class="theme-img-card"
                 onclick="showThemeInfo(
                     'Pastel Dream',
                     'Pastel_Dream',
                     'A soft and sweet baby shower theme using pastel pink, blue, and mint tones. Features balloon clouds, star mobiles, and sweet table setups. Ideal for baby shower celebrations and gender reveal parties. Brings warmth and joy to welcome your little one.')">
                <img src="${pageContext.request.contextPath}/images/themes/Pastel_Dream.jpg" alt="Baby Shower"/>
                <div class="theme-img-caption">Pastel Dream</div>
            </div>

            <div class="theme-img-card"
                 onclick="showThemeInfo(
                     'Festive Sparkle',
                     'Festival_Sparkle',
                     'A vibrant and colorful festival theme bursting with energy. Perfect for Dashain, Tihar, Teej, New Year, or any cultural celebration. Features bright diyo lights, colorful rangoli, traditional elements mixed with modern decoration to create a festive atmosphere.')">
                <img src="${pageContext.request.contextPath}/images/themes/Festival_Sparkle.jpg" alt="Festival"/>
                <div class="theme-img-caption">Festive Sparkle</div>
            </div>

            <div class="theme-img-card"
                 onclick="showThemeInfo(
                     'Bollywood Glam',
                     'Bollywood_Glam',
                     'A glamorous and celebratory graduation theme with golden star decorations, photo backdrops, and achievement banners. Perfect for graduation parties, farewell events, and academic milestones. Makes every graduate feel like a star on their special day.')">
                <img src="${pageContext.request.contextPath}/images/themes/Bollywood_Glam.jpg" alt="Graduation"/>
                <div class="theme-img-caption">Bollywood Glam</div>
            </div>

        </div>
    </div>
</div>


<!-- ============ EVENT TYPES SECTION ============ -->
<div class="events-section" id="event-services">
    
    <!-- ===== SEARCH BAR ===== -->
<div style="margin-bottom:24px;">
    <input type="text" id="searchInput"
           placeholder="Search events... (e.g. Birthday, Wedding)"
           onkeyup="filterEvents()"
           style="width:100%; padding:12px 16px; border:2px solid #c9a96e;
                  border-radius:10px; font-size:1rem; outline:none;
                  box-sizing:border-box;"/>
</div>
    
    <h2>Our Event Services</h2>
    <p class="section-sub">Make Your Moment Magical 💖</p>

    <%--
        ★ NEW: "Add to Wishlist" button added for logged-in regular users.
        Admin does NOT see the wishlist button.
        Not-logged-in users see "Book Now" which takes them to register.
    --%>
    <div class="card-grid" style="display:flex; flex-wrap:wrap; gap:22px;">
        <%
            List<EventType> eventTypes = (List<EventType>) request.getAttribute("eventTypes");

            if (eventTypes != null && !eventTypes.isEmpty()) {
                for (EventType et : eventTypes) {

                    // Pick image by matching event name keywords
                    String eventNameLower = et.getEventName().toLowerCase();
                    String img;
                    if (eventNameLower.contains("birthday"))        img = "birthday";
                    else if (eventNameLower.contains("anniversary")) img = "anniversary";
                    else if (eventNameLower.contains("engagement"))  img = "engagement";
                    else if (eventNameLower.contains("baby"))        img = "babyshower";
                    else if (eventNameLower.contains("graduation"))  img = "graduation";
                    else if (eventNameLower.contains("corporate"))   img = "corporate";
                    else if (eventNameLower.contains("festival"))    img = "festival";
                    else if (eventNameLower.contains("farewell"))    img = "farewell";
                    else if (eventNameLower.contains("reception"))   img = "reception";
                    else if (eventNameLower.contains("new year"))    img = "newyear";
                    else                                             img = "birthday"; // default

                    String safeName = et.getEventName().replace("'", "\\'");
                    String safeDesc = (et.getDescription() != null)
                        ? et.getDescription().replace("'", "\\'")
                        : "Beautiful decoration for your special day.";
        %>
        <div class="event-card">
            <img src="${pageContext.request.contextPath}/images/themes/<%= img %>.jpg"
                 alt="<%= et.getEventName() %>"
                 onerror="this.src='${pageContext.request.contextPath}/images/themes/birthday.jpg'"/>
            <div class="event-card-body">
                <h3><%= et.getEventName() %></h3>
                <p><%= et.getDescription() != null ? et.getDescription() : "Beautiful decoration for your special day." %></p>
                <p class="price">From Rs. <%= et.getBasePrice() %></p>

                <% if (!isLoggedIn) { %>
    				<a href="${pageContext.request.contextPath}/register" class="book-btn">Book Now</a>
    				<a href="${pageContext.request.contextPath}/login" class="wishlist-btn" style="text-align:center; text-decoration:none;">♡ Add to Wishlist</a>

                <% } else if (!isAdmin) { %>
                    <%-- Regular user: Book Now button --%>
                    <a href="${pageContext.request.contextPath}/booking?eventTypeId=<%= et.getEventId() %>" class="book-btn">Book Now</a>

                    <%-- ★ NEW: Add to Wishlist button (only for regular users) --%>
                    <button class="wishlist-btn"
                            onclick="addToWishlist('<%= et.getEventId() %>', '<%= safeName %>', '<%= et.getBasePrice() %>')">
                        ♡ Add to Wishlist
                    </button>

                <% } %>
                <%-- Admin sees no buttons on event cards (they manage from admin panel) --%>
            </div>
        </div>
        <%
                }
            } else {
        %>
        <p style="color: var(--text-light); padding: 30px;">
            No event types available yet. Admin can add them from the Admin Dashboard.
        </p>
        <% } %>
    </div>
</div>

<!-- ============ FOOTER ============ -->
<footer>
    <h3><p><strong style="color: var(--gold);">✦ OccasioDesign</strong> - Pokhara, Nepal</p></h3>
    <h3><p style="margin-top: 8px;">📞 9810000000 &nbsp;|&nbsp; ✉ info@occasiodesign.com.np</p></h3>
    <h4><p style="margin-top: 12px; font-size: 0.8rem;">© 2026 OccasioDesign. All rights reserved.</p></h4>
</footer>


<!-- =============================================================== 
<!--  ★ NEW POPUP 1: THEME INFO POPUP                                
<!-- =============================================================== -->

<div class="popup-overlay" id="themeInfoOverlay">
    <div class="popup-box">
        <!-- Big image of the theme -->
        <img id="themeInfoImage" src="" alt="Theme"/>
        <!-- Theme name as title -->
        <h2 id="themeInfoTitle"></h2>
        <!-- Theme description paragraph -->
        <p id="themeInfoDesc"></p>
        <!-- Back button closes the popup -->
        <button class="back-btn" onclick="hideThemeInfo()">← Back</button>
    </div>
</div>


<!-- ===============================================================
<!--  ★ NEW POPUP 2: MY WISHLIST POPUP                               
<!-- =============================================================== -->

<div class="popup-overlay" id="wishlistOverlay">
    <div class="popup-box">
        <h2>♡ My Wishlist</h2>
        <!-- Wishlist items are added here by JavaScript -->
        <div id="wishlistItemsContainer"></div>
        <!-- Back button closes the popup -->
        <button class="back-btn" onclick="hideWishlist()">← Back</button>
    </div>
</div>


<!-- =============================================================== 
<!--  ★ NEW TOAST: THANK YOU MESSAGE                                
<!-- =============================================================== -->

<div id="thankYouToast">
    ✓ Added to Wishlist! Thank you 🎉
</div>


<!-- =============================================================== 
<!--  ★ NEW JAVASCRIPT                                              
<!-- =============================================================== -->

<script>
    // -------------------------------------------------------
    // WISHLIST STORAGE
    // We store wishlist in sessionStorage (browser memory).
    // It stays as long as the browser tab is open.
    // It is a list (array) of objects like:
    //   { id: "1", name: "Birthday Party", price: "5000" }
    // -------------------------------------------------------
    var wishlist = JSON.parse(sessionStorage.getItem('occasio_wishlist') || '[]');


    // -------------------------------------------------------
    // FEATURE 1: THEME INFO POPUP
    // Called when user clicks a theme card.
    // Parameters:
    //   name        = theme name (e.g. "Enchanted Garden")
    //   imageFile   = image filename without extension (e.g. "birthday_rainbow")
    //   description = text to show about this theme
    // -------------------------------------------------------
    function showThemeInfo(name, imageFile, description) {
        // Fill in the popup with the theme's details
        document.getElementById('themeInfoTitle').innerText = name;
        document.getElementById('themeInfoDesc').innerText = description;
        document.getElementById('themeInfoImage').src =
            '${pageContext.request.contextPath}/images/themes/' + imageFile + '.jpg';
        document.getElementById('themeInfoImage').alt = name;

        // Show the popup (flex makes it center on screen)
        document.getElementById('themeInfoOverlay').style.display = 'flex';
    }

    function hideThemeInfo() {
        // Hide the popup
        document.getElementById('themeInfoOverlay').style.display = 'none';
    }

    // Close theme popup if user clicks outside the white box
    document.getElementById('themeInfoOverlay').addEventListener('click', function(e) {
        if (e.target === this) hideThemeInfo();
    });


    // -------------------------------------------------------
    // FEATURE 2: ADD TO WISHLIST
    // Called when user clicks "♡ Add to Wishlist" button.
    // Parameters:
    //   id    = event ID from database
    //   name  = event name (e.g. "Birthday Party")
    //   price = base price (e.g. "5000")
    // -------------------------------------------------------
    function addToWishlist(id, name, price) {
        // Check if this event is already in the wishlist
        var alreadyAdded = wishlist.some(function(item) {
            return item.id === id;
        });

        if (alreadyAdded) {
            // Already in wishlist — tell user
            document.getElementById('thankYouToast').innerText = '⚠ Already in your Wishlist!';
        } else {
            // Add it to the wishlist array
            wishlist.push({ id: id, name: name, price: price });
            // Save updated wishlist to browser memory
            sessionStorage.setItem('occasio_wishlist', JSON.stringify(wishlist));
            document.getElementById('thankYouToast').innerText = '✓ Added to Wishlist! Thank you 🎉';
        }

        // Show the thank you toast message
        showThankYouToast();
    }


    // -------------------------------------------------------
    // FEATURE 3: THANK YOU TOAST
    // Shows a small message at top of screen for 2.5 seconds
    // -------------------------------------------------------
    function showThankYouToast() {
        var toast = document.getElementById('thankYouToast');
        toast.style.display = 'block';

        // After 2.5 seconds, hide it automatically
        setTimeout(function() {
            toast.style.display = 'none';
        }, 2500);
    }


    // -------------------------------------------------------
    // FEATURE 4: SHOW WISHLIST POPUP
    // Called when user clicks "♡ My Wishlist" in nav bar
    // -------------------------------------------------------
    function showWishlist() {
        var container = document.getElementById('wishlistItemsContainer');

        if (wishlist.length === 0) {
            // No items yet — show a friendly message
            container.innerHTML = '<p class="wishlist-empty">Your wishlist is empty.<br>Go ahead and add some events! 💖</p>';
        } else {
            // Build the list of wishlist items
            var html = '';
            wishlist.forEach(function(item) {
                html += '<div class="wishlist-item">' +
                            '<div>' +
                                '<div class="wishlist-item-name">' + item.name + '</div>' +
                                '<div class="wishlist-item-price">From Rs. ' + item.price + '</div>' +
                            '</div>' +
                        '</div>';
            });
            container.innerHTML = html;
        }

        // Show the wishlist popup
        document.getElementById('wishlistOverlay').style.display = 'flex';
    }

    function hideWishlist() {
        document.getElementById('wishlistOverlay').style.display = 'none';
    }

    // Close wishlist popup if user clicks outside the white box
    document.getElementById('wishlistOverlay').addEventListener('click', function(e) {
        if (e.target === this) hideWishlist();
    });
    
    /* Search function — user type garda event cards filter hunxa... */
    function filterEvents() {
    var input = document.getElementById('searchInput').value.toLowerCase();
    var cards = document.querySelectorAll('.event-card');

    cards.forEach(function(card) {
        var name = card.querySelector('h3');
        if (name) {
            var text = name.innerText.toLowerCase();
         
            if (text.includes(input)) {
                card.style.display = 'flex'; /* flex --- kina bhane event---card hamro flex xa */
            } else {
                card.style.display = 'none'; /* hide gara yo card...  */
            }
        }
    });
}
    
</script>

</body>
</html>
