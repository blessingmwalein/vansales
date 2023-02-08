import { Injectable, CanActivate, ExecutionContext, Inject, forwardRef } from "@nestjs/common";
import { Reflector } from "@nestjs/core";
import { UsersService } from '../../users/users.service';
import Role from "src/enums/role";


@Injectable()
export class RolesGuard implements CanActivate {
    constructor(
        private reflector: Reflector,
        private userService: UsersService
    ) { }

    //can activate
    async canActivate(context: ExecutionContext): Promise<boolean> {
        const request = context.switchToHttp().getRequest();
        if (!request.headers.authorization) return false;
        const decodedUser: any = this.userService.decodeToken(request.headers.authorization.split(" ")[1]);
        const user = await this.userService.findUserById(decodedUser._id);
        return user?.role.includes(Role.Admin);
    }
}