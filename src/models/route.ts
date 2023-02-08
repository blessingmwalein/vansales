
export class Route {
    _id: string;
    code: string;
    name: string;
    origin: Point;
    destination: Point;
    waypoints: Point[];
    average_distance: number;
    average_duration: number;
    updated_at: Date;
    created_at: Date;
}

export class Point {
    type: string;
    coordinates: number[];
}

