import { Test, TestingModule } from '@nestjs/testing';
import { StockAllocationService } from './stock-allocation.service';

describe('StockAllocationService', () => {
  let service: StockAllocationService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [StockAllocationService],
    }).compile();

    service = module.get<StockAllocationService>(StockAllocationService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
