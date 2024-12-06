{
  boot = {
    kernel.sysctl = {
      # https://wiki.archlinux.org/title/Gaming#Increase_vm.max_map_count
      "vm.max_map_count" = 2147483642;
    };
    kernelParams = [
      # set mouse, gamepad/joysticks, and keyboards to have
      # a poll rate of 250 Hz
      "usbhid.mousepoll=4"
      "usbhid.jspoll=4"
      "usbhid.kbpoll=4"

      # https://wiki.archlinux.org/title/Gaming#Improve_clock_gettime_throughput
      # switch from hpet (high precision event timer) or acpi_pm 
      # (ACPI Power Management Timer) to the faster TSC 
      # (time stamp counter) timer. 
      "tsc=reliable"
      "clocksource=tsc"
    ];
  };
  
  programs.cfs-zen-tweaks.enable = true;

  # https://wiki.archlinux.org/title/Gaming#Tweaking_kernel_parameters_for_response_time_consistency
  # --> (https://wiki.archlinux.org/title/Gaming#Make_the_changes_permanent)
  # The following kernel parameter changes improve the response time 
  # consistency for the realtime kernel as well as other kernels such 
  # as the default linux kernel: 
  systemd.tmpfiles.settings = {
    consistent-response-time-for-gaming = {
      "/proc/sys/vm/compaction_proactiveness" = { w = { argument = "0"; }; };
      "/proc/sys/vm/watermark_boost_factor" = { w = { argument = "1"; }; };
      "/proc/sys/vm/min_free_kbytes" = { w = { argument = "1048576"; }; };
      "/proc/sys/vm/watermark_scale_factor" = { w = { argument = "500"; }; };
      "/proc/sys/vm/swappiness" = { w = { argument = "10"; }; };
      "/sys/kernel/mm/lru_gen/enabled" = { w = { argument = "5"; }; };
      "/proc/sys/vm/zone_reclaim_mode" = { w = { argument = "0"; }; };
      "/sys/kernel/mm/transparent_hugepage/enabled" = { w = { argument = "madvise"; }; };
      "/sys/kernel/mm/transparent_hugepage/shmem_enabled" = { w = { argument = "advise"; }; };
      "/sys/kernel/mm/transparent_hugepage/defrag" = { w = { argument = "never"; }; };
      "/proc/sys/vm/page_lock_unfairness" = { w = { argument = "1"; }; };
    };
  };
}
