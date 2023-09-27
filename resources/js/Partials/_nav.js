
//create nav list items

const NavItems = [
    {
        name: 'Dashboard',
        icon: 'bi bi-pie-chart-fill',
        feature: 'dashboard',
        route: '/dashboard',
        children: [

        ]
    },
    {
        name: 'User Management',
        icon: 'bi bi-people-fill',
        feature: 'user_management',
        route: '/users',
        children: [
            {
                name: 'Users',
                route: '/admin/users',
                feature: 'user_management',
            },
            {
                name: 'Roles',
                route: '/admin/users/roles',
                feature: 'role_permission_management',
            },
            {
                name: 'Permissions',
                route: '/admin/users/permissions',
                feature: 'role_permission_management',
            },
        ]
    }
]

export default NavItems;