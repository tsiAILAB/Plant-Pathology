package com.tsi.plantdiagnosissystem.ui.configurations.ui;

import android.content.Context;

import androidx.annotation.Nullable;
import androidx.fragment.app.Fragment;
import androidx.fragment.app.FragmentManager;
import androidx.fragment.app.FragmentPagerAdapter;


/**
 * A [FragmentPagerAdapter] that returns a fragment corresponding to
 * one of the sections/tabs/pages.
 */
public class SectionsPagerAdapter extends FragmentPagerAdapter {

    private static final String [] TAB_TITLES = {"Update API", "Add Crop"};
    private final Context mContext;

    public SectionsPagerAdapter(Context context, FragmentManager fm) {
        super(fm);
        mContext = context;
    }

    @Override
    public Fragment getItem(int position) {
        // getItem is called to instantiate the fragment for the given page.
        // Return a placeholderFragment (defined as a static inner class below).
        switch (position) {
            case 0:
                ConfigApiNameFragment configApiNameFragment = new ConfigApiNameFragment();
                return configApiNameFragment;
            case 1:
                ConfigPlantImageFragment configPlantImageFragment = new ConfigPlantImageFragment();
                return configPlantImageFragment;
            default:
                ConfigApiNameFragment configApiNameFragment2 = new ConfigApiNameFragment();
                return configApiNameFragment2;
        }
    }

    @Nullable
    @Override
    public CharSequence getPageTitle(int position) {
        return TAB_TITLES[position];
    }

    @Override
    public int getCount() {
        // Show 2 total pages.
        return 2;
    }
}