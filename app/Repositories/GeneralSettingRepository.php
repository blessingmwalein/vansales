<?php

namespace App\Repositories;

use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Models\GeneralSetting;

class GeneralSettingRepository implements GeneralSettingRepositoryInterface
{
    public function all()
    {
        return GeneralSetting::all();
    }

    public function create(array $data)
    {
        return GeneralSetting::create($data);
    }

    public function update(array $data, $id)
    {
        $record = GeneralSetting::find($id);

        return $record->update($data);
    }

    public function delete($id)
    {
        return GeneralSetting::destroy($id);
    }

    public function show($id)
    {
        return GeneralSetting::find($id);
    }

    public function getPaginated($perPage = 10)
    {
        return GeneralSetting::latest()->paginate($perPage);
    }

    //get warehouse setting
    public function getWarehouseSetting()
    {
        return GeneralSetting::where('type', 'warehouse')->first();
    }

    //get truck setting
    public function getTruckSetting()
    {
        return GeneralSetting::where('type', 'truck')->first();
    }

    public function updateGeneralSettings(array $data)
    {
        foreach ($data as $key => $value) {
            $setting = GeneralSetting::where('id', $value['id'])->first();
            if ($setting) {
                $setting->update(['value' => $value['value']]);
            }
        }

        return true;
    }
}
