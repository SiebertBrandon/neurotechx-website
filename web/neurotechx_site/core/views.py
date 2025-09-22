from django.http import HttpResponse


def index(request):
    user = request.user if request.user.is_authenticated else None
    who = getattr(user, "username", "anonymous")
    role = (
        "admin"
        if getattr(user, "is_superuser", False)
        else ("user" if user else "guest")
    )
    return HttpResponse(f"<h1>Hello, {who}!</h1><p>Role: {role}</p><p>It works 🎉</p>")
