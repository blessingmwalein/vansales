import { Test, TestingModule } from '@nestjs/testing';
import { StockAllocationController } from './stock-allocation.controller';

describe('StockAllocationController', () => {
  let controller: StockAllocationController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [StockAllocationController],
    }).compile();

    controller = module.get<StockAllocationController>(StockAllocationController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
