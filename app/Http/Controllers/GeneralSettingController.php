<?php

namespace App\Http\Controllers;

use App\Interfaces\GeneralSettingRepositoryInterface;
use App\Models\GeneralSetting;
use Illuminate\Http\Request;
use Inertia\Inertia;

class GeneralSettingController extends Controller
{

    private GeneralSettingRepositoryInterface $generalSettingRepository;

    public function __construct(GeneralSettingRepositoryInterface $generalSettingRepository)
    {
        $this->generalSettingRepository = $generalSettingRepository;
    }
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        return Inertia::render('Settings/General', [
            'generalSettings' => $this->generalSettingRepository->getAllCompanyGeneralSettings(auth()->user()->company_id),
        ]);
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {

        $data = $request->validate([
            'type' => 'nullable|string',
            'name' => 'required|string|unique:general_settings,name',
            'value' => 'required|boolean',
        ]);

        $this->generalSettingRepository->create($data);
        return redirect()->back()->with('success', 'General setting created successfully');
    }

    /**
     * Display the specified resource.
     */
    public function show(GeneralSetting $generalSetting)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(GeneralSetting $generalSetting)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, GeneralSetting $generalSetting)
    {
        $data = $request->validate([
            'type' => 'nullable|string',
            'name' => 'required|string|unique:general_settings,name,' . $generalSetting->id,
            'value' => 'required|boolean',
        ]);
        $this->generalSettingRepository->update($data, $generalSetting->id);
        return redirect()->back()->with('success', 'General setting updated successfully');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(GeneralSetting $generalSetting)
    {
        $this->generalSettingRepository->delete($generalSetting->id);
        return redirect()->back()->with('success', 'General setting deleted successfully');
    }

    public function updateGeneralSettings(Request $request)
    {
        $settings = $request->validate([
            'general_settings' => 'required|array',
        ]);

        $this->generalSettingRepository->updateGeneralSettings($settings['general_settings']);

        return redirect()->back()->with('success', 'General settings updated successfully');
    }

    public function setDefaultSettingsForCompany(Request $request)
    {

        $companyId = $request->company_id;

        // dd($companyId);

        if (!$companyId) {
            return redirect()->back()->with('error', 'Company id is required');
        }
        $this->generalSettingRepository->setDefaultSettingsForCompany($companyId);

        return redirect()->back()->with('success', 'Default settings set successfully');
    }
}
