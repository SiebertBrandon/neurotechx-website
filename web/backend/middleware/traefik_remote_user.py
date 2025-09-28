from __future__ import annotations
from django.contrib.auth import get_user_model, login
from django.utils.deprecation import MiddlewareMixin
from django.conf import settings

User = get_user_model()


class RemoteUserHeaderMiddleware(MiddlewareMixin):
    """
    Trust identity headers set by oauth2-proxy/Traefik.
    Default email header: X-Auth-Request-Email  -> request.META['HTTP_X_AUTH_REQUEST_EMAIL']
    Optional display name: X-Auth-Request-User
    Creates the user if missing, keeps is_staff/superuser in sync via ADMIN_EMAILS env.
    """

    def process_request(self, request):
        header = settings.REMOTE_USER_HEADER
        email = request.META.get(header, "")
        if not email:
            return  # unauthenticated path; your routers should have enforced auth at Traefik level

        email = email.strip().lower()
        name = request.META.get(settings.REMOTE_NAME_HEADER, "") or email.split("@")[0]
        user, created = User.objects.get_or_create(
            username=email, defaults={"email": email, "first_name": name[:150]}
        )
        # Promote/demote based on ADMIN_EMAILS
        is_admin = email in settings.ADMIN_EMAILS_SET
        if (user.is_staff != is_admin) or (user.is_superuser != is_admin):
            user.is_staff = is_admin
            user.is_superuser = is_admin
            user.save(update_fields=["is_staff", "is_superuser"])
        # Ensure session logged in
        if (
            not getattr(request, "user", None)
            or not request.user.is_authenticated
            or request.user.pk != user.pk
        ):
            login(request, user)
