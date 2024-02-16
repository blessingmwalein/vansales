
//create nav list items

const NavItems = [
    {
        name: 'Dashboard',
        icon: 'bi bi-pie-chart-fill',
        feature: 'dashboard',
        route: '/company/dashboard',
        children: [

        ]
    },
    {
        name: 'Companies',
        icon: 'bi bi-buildings',
        feature: 'company_management',
        route: '/admin/companies',
        children: [

        ]
    },
    {
        name: 'Subscriptions',
        icon: 'bi bi-boxes',
        feature: 'subscription_management',
        route: '/admin/subscriptions',
        children: [

        ]
    },
    {
        name: 'Warehouse',
        icon: 'bi bi-houses-fill',
        feature: 'warehouse_management',
        route: '/company/warehouses',
        children: [

        ]
    },
    {
        name: 'Sales',
        icon: 'bi bi-basket',
        feature: 'sales_management',
        route: '/company/sales',
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
                route: '/company/product-categories',
                feature: 'product_management',
            },
            {
                name: 'Utilities',
                route: '/company/utilities',
                feature: 'product_management',
            },
            {
                name: 'Products',
                route: '/company/products',
                feature: 'product_management',
            }
            // {
            //     name: 'Stock Allocation',
            //     route: '/company/stock-allocations',
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
        name: 'Employee Management',
        icon: 'bi bi-people-fill',
        feature: 'employee_management',
        route: '/employees',
        children: [
            {
                name: 'Employees',
                route: '/company/employees',
                feature: 'employee_management',
            },
        ]
    },
    {
        name: 'Trucks',
        icon: 'bi bi-truck',
        feature: 'truck_management',
        route: '/company/trucks',
        children: [

        ]
    },
    {
        name: 'Customers',
        icon: 'bi bi-people-fill',
        feature: 'customer_management',
        route: '/company/customers',
        children: [

        ]
    },
    {
        name: 'Routes',
        icon: 'bi bi-pin-map-fill',
        feature: 'route_management',
        route: '/company/routes',
        children: [

        ]
    },
    {
        name: 'Loadsheets',
        icon: 'bi bi-layout-text-sidebar-reverse',
        feature: 'loadsheet_management',
        route: '/company/loadsheets',
        children: [

        ]
    },
    {
        name: 'Deliveries',
        icon: 'bi bi-layout-text-sidebar-reverse',
        feature: 'delivery_management',
        route: '/company/deliveries',
        children: [

        ]
    },
    {
        name: 'Settings',
        icon: 'bi bi-gear-fill',
        feature: 'settings_management',
        route: '/company/settings',
        children: [
            {
                name: 'Product',
                feature: 'product_settings_management',
                route: '/company/settings/product-settings',
            },
            {
                name: 'General',
                feature: 'general_settings_management',
                route: '/company/settings/general-settings',
            }
        ]
    },
]

export default NavItems;
