<?php

namespace App\Interfaces;

interface GeneralSettingRepositoryInterface
{
    public function all();

    public function getAllCompanyGeneralSettings($companyId);

    public function create(array $data);

    public function update(array $data, $id);

    public function delete($id);

    public function show($id);

    public function getPaginated($perPage = 10);

    //create function to updateGeneralSettings
    public function updateGeneralSettings(array $data);

    public function checkIfSettingIsActivated($settingType);

    public function setDefaultSettingsForCompany($companyId);
}
