<header class="bg-blue-500 py-4">
    <div class="container mx-auto px-4 flex justify-between items-center">
        <h1 class="text-white text-2xl font-bold">Personal Finance Tracker</h1>
        <div class="relative">
            <img src="/img/avatar.png" alt="User Avatar" class="h-10 w-10 rounded-full cursor-pointer" id="avatar">
            <div class="absolute right-0 mt-2 w-48 bg-white rounded-md shadow-lg py-2 z-20 hidden" id="dropdown">
                <p class="px-4 py-2 text-gray-700"><%= session.getAttribute("user") %></p>
            </div>
        </div>
    </div>
</header>

<script>
    document.getElementById("avatar").addEventListener("click", function() {
        var dropdown = document.getElementById("dropdown");
        dropdown.classList.toggle("hidden");
    });
    
    // Hide the dropdown if user clicks outside of it
    window.addEventListener("click", function(event) {
        var dropdown = document.getElementById("dropdown");
        if (!event.target.matches('#avatar')) {
            if (!dropdown.classList.contains('hidden')) {
                dropdown.classList.add('hidden');
            }
        }
    });
</script>
