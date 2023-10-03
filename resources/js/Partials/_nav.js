
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
        name: 'Warehouse',
        icon: 'bi bi-houses-fill',
        feature: 'warehouse_management',
        route: '/admin/warehouses',
        children: [

        ]
    },
    {
        name: 'Stock Management',
        icon: 'bi bi-database-fill',
        feature: 'inventory_management',
        route: '/stock',
        children: [
            {
                name: 'Product Categories',
                route: '/admin/product-categories',
                feature: 'product_management',
            },
            {
                name: 'Utilities',
                route: '/admin/utilities',
                feature: 'product_management',
            },
            {
                name: 'Products',
                route: '/admin/products',
                feature: 'product_management',
            }
            // {
            //     name: 'Stock Allocation',
            //     route: '/admin/stock-allocations',
            //     feature: 'inventory_management',
            // },
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
                route: '/admin/roles',
                feature: 'role_permission_management',
            },
            {
                name: 'Permissions',
                route: '/admin/permissions',
                feature: 'role_permission_management',
            },
        ]
    },
    {
        name: 'Trucks',
        icon: 'bi bi-truck',
        feature: 'truck_management',
        route: '/admin/trucks',
        children: [

        ]
    },
    {
        name: 'Customers',
        icon: 'bi bi-people-fill',
        feature: 'customer_management',
        route: '/admin/customers',
        children: [

        ]
    },
    {
        name: 'Routes',
        icon: 'bi bi-pin-map-fill',
        feature: 'route_management',
        route: '/admin/routes',
        children: [

        ]
    },
    {
        name: 'Loadsheets',
        icon: 'bi bi-layout-text-sidebar-reverse',
        feature: 'loadsheet_management',
        route: '/admin/loadsheets',
        children: [

        ]
    },
    {
        name: 'Settings',
        icon: 'bi bi-gear-fill',
        feature: 'settings_management',
        route: '/admin/settings',
        children: [
            {
                name: 'Product',
                feature: 'product_settings_management',
                route: '/admin/settings/product-settings',
            }
        ]
    },
]

export default NavItems;