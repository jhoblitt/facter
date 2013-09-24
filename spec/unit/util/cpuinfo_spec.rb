#! /usr/bin/env ruby

require 'spec_helper'
require 'facter/util/cpuinfo'

describe Facter::Util::Cpuinfo do

  shared_examples 'linux' do |fixture, cores, data|
    let(:cinfo) do
      path = cpuinfo_fixtures(fixture)
      Facter::Util::Cpuinfo.parse(path)
    end

    it { expect(cinfo).to be_a_kind_of(Array) }
    it { expect(cinfo.length).to eq(cores) }
    it { cinfo.each {|cpu| expect(cpu).to be_a_kind_of(Hash)} }
    it do
      index = 0
      cinfo.each do |cpu|
        expect(cpu).to include(data[index])
        index += 1
      end
    end
  end

  describe "on linux" do
    require 'facter_spec/cpuinfo'
    include FacterSpec::Cpuinfo

    describe "with architecture amd64" do
      describe "with amd64solo fixture" do
        it_behaves_like 'linux', 'amd64solo', 1, [
          {
            "processor"        => "0",
            "vendor_id"        => "GenuineIntel",
            "cpu_family"       => "6",
            "model"            => "23",
            "model_name"       => "Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz",
            "stepping"         => "10",
            "cpu_mhz"          => "600.825",
            "cache_size"       => "6144 KB",
            "fdiv_bug"         => "no",
            "hlt_bug"          => "no",
            "f00f_bug"         => "no",
            "coma_bug"         => "no",
            "fpu"              => "yes",
            "fpu_exception"    => "yes",
            "cpuid_level"      => "5",
            "wp"               => "yes",
            "flags"            => "fpu vme de pse tsc msr mce cx8 apic mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 constant_tsc up pni monitor ssse3",
            "bogomips"         => "1201.65",
            "clflush_size"     => "64",
            "cache_alignment"  => "64",
            "address_sizes"    => "36 bits physical, 48 bits virtual",
            #"power_management" => ""
          },
        ]
      end

      describe "with amd64dual fixture" do
        p0 = {
          "processor"       => "0",
          "vendor_id"       => "GenuineIntel",
          "cpu_family"      => "6",
          "model"           => "23",
          "model_name"      => "Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz",
          "stepping"        => "10",
          "cpu_mhz"         => "689.302",
          "cache_size"      => "6144 KB",
          "physical_id"     => "0",
          "siblings"        => "2",
          "core_id"         => "0",
          "cpu_cores"       => "2",
          "apicid"          => "0",
          "initial_apicid"  => "0",
          "fdiv_bug"        => "no",
          "hlt_bug"         => "no",
          "f00f_bug"        => "no",
          "coma_bug"        => "no",
          "fpu"             => "yes",
          "fpu_exception"   => "yes",
          "cpuid_level"     => "5",
          "wp"              => "yes",
          "flags"           => "fpu vme de pse tsc msr mce cx8 apic mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht constant_tsc pni ssse3",
          "bogomips"        => "1378.60",
          "clflush_size"    => "64",
          "cache_alignment" => "64",
          "address_sizes"   => "36 bits physical, 48 bits virtual",
        }

        it_behaves_like 'linux', 'amd64dual', 2, [
          p0,
          p0.merge({
            "processor" => "1",
            "core_id"   => "1",
            "apicid"    => "1",
            "initial_apicid"  => "1",
            "bogomips"  => "1687.45",
          }),
        ]
      end

      describe "with amd64tri fixture" do
        p0 = {
          "processor"       => "0",
          "vendor_id"       => "GenuineIntel",
          "cpu_family"      => "6",
          "model"           => "23",
          "model_name"      => "Intel(R) Core(TM)2 Duo CPU     P8700  @ 2.53GHz",
          "stepping"        => "10",
          "cpu_mhz"         => "910.177",
          "cache_size"      => "6144 KB",
          "physical_id"     => "0",
          "siblings"        => "3",
          "core_id"         => "0",
          "cpu_cores"       => "3",
          "apicid"          => "0",
          "initial_apicid"  => "0",
          "fdiv_bug"        => "no",
          "hlt_bug"         => "no",
          "f00f_bug"        => "no",
          "coma_bug"        => "no",
          "fpu"             => "yes",
          "fpu_exception"   => "yes",
          "cpuid_level"     => "5",
          "wp"              => "yes",
          "flags"           => "fpu vme de pse tsc msr mce cx8 apic mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht constant_tsc pni ssse3",
          "bogomips"        => "1820.35",
          "clflush_size"    => "64",
          "cache_alignment" => "64",
          "address_sizes"   => "36 bits physical, 48 bits virtual",
        }

        it_behaves_like 'linux', 'amd64tri', 3, [
          p0,
          p0.merge({
            "processor"      => "1",
            "core_id"        => "1",
            "apicid"         => "1",
            "initial_apicid" => "1",
            "bogomips"       => "1875.49",
          }),
          p0.merge({
            "processor"      => "2",
            "core_id"        => "2",
            "apicid"         => "2",
            "initial_apicid" => "2",
            "bogomips"       => "1523.26",
          }),
        ]
      end

      describe "with amd64quad fixture" do
        p0 = {
          "processor"       => "0",
          "vendor_id"       => "AuthenticAMD",
          "cpu_family"      => "16",
          "model"           => "4",
          "model_name"      => "Quad-Core AMD Opteron(tm) Processor 2374 HE",
          "stepping"        => "2",
          "cpu_mhz"         => "1386667.908",
          "cache_size"      => "512 KB",
          "fpu"             => "yes",
          "fpu_exception"   => "yes",
          "cpuid_level"     => "5",
          "wp"              => "yes",
          "flags"           => "fpu de tsc msr pae cx8 cmov pat clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt lm 3dnowext 3dnow constant_tsc rep_good nonstop_tsc pni cx16 popcnt lahf_lm cmp_legacy extapic cr8_legacy abm sse4a misalignsse 3dnowprefetch",
          "bogomips"        => "4400.17",
          "tlb_size"        => "1024 4K pages",
          "clflush_size"    => "64",
          "cache_alignment" => "64",
          "address_sizes"   => "48 bits physical, 48 bits virtual",
        }

        it_behaves_like 'linux', 'amd64quad', 4, [
          p0,
          p0.merge({
            "processor"      => "1",
          }),
          p0.merge({
            "processor"      => "2",
          }),
          p0.merge({
            "processor"      => "3",
          }),
        ]
      end

      describe "with amd64twentyfour fixture" do
        p0 = {
          "processor"       => "0",
          "vendor_id"       => "GenuineIntel",
          "cpu_family"      => "6",
          "model"           => "44",
          "model_name"      => "Intel(R) Xeon(R) CPU           X5675  @ 3.07GHz",
          "stepping"        => "2",
          "cpu_mhz"         => "3068.000",
          "cache_size"      => "12288 KB",
          "physical_id"     => "0",
          "siblings"        => "12",
          "core_id"         => "0",
          "cpu_cores"       => "6",
          "apicid"          => "0",
          "initial_apicid"  => "0",
          "fpu"             => "yes",
          "fpu_exception"   => "yes",
          "cpuid_level"     => "11",
          "wp"              => "yes",
          "flags"           => "fpu vme de pse tsc msr pae mce cx8 apic mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 cx16 xtpr pdcm dca sse4_1 sse4_2 popcnt aes lahf_lm ida arat epb dts tpr_shadow vnmi flexpriority ept vpid",
          "bogomips"        => "6133.05",
          "clflush_size"    => "64",
          "cache_alignment" => "64",
          "address_sizes"   => "40 bits physical, 48 bits virtual",
        }

        it_behaves_like 'linux', 'amd64twentyfour', 24, [
          p0,
          p0.merge({
            "processor"      => "1",
            "physical_id"    => "0",
            "core_id"        => "1",
            "apicid"         => "2",
            "initial_apicid" => "2",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "2",
            "physical_id"    => "0",
            "core_id"        => "2",
            "apicid"         => "4",
            "initial_apicid" => "4",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "3",
            "physical_id"    => "0",
            "core_id"        => "8",
            "apicid"         => "16",
            "initial_apicid" => "16",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "4",
            "physical_id"    => "0",
            "core_id"        => "9",
            "apicid"         => "18",
            "initial_apicid" => "18",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "5",
            "physical_id"    => "0",
            "core_id"        => "10",
            "apicid"         => "20",
            "initial_apicid" => "20",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "6",
            "physical_id"    => "1",
            "core_id"        => "0",
            "apicid"         => "32",
            "initial_apicid" => "32",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "7",
            "physical_id"    => "1",
            "core_id"        => "1",
            "apicid"         => "34",
            "initial_apicid" => "34",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "8",
            "physical_id"    => "1",
            "core_id"        => "2",
            "apicid"         => "36",
            "initial_apicid" => "36",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "9",
            "physical_id"    => "1",
            "core_id"        => "8",
            "apicid"         => "48",
            "initial_apicid" => "48",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "10",
            "physical_id"    => "1",
            "core_id"        => "9",
            "apicid"         => "50",
            "initial_apicid" => "50",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "11",
            "physical_id"    => "1",
            "core_id"        => "10",
            "apicid"         => "52",
            "initial_apicid" => "52",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "12",
            "physical_id"    => "0",
            "core_id"        => "0",
            "apicid"         => "1",
            "initial_apicid" => "1",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "13",
            "physical_id"    => "0",
            "core_id"        => "1",
            "apicid"         => "3",
            "initial_apicid" => "3",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "14",
            "physical_id"    => "0",
            "core_id"        => "2",
            "apicid"         => "5",
            "initial_apicid" => "5",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "15",
            "physical_id"    => "0",
            "core_id"        => "8",
            "apicid"         => "17",
            "initial_apicid" => "17",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "16",
            "physical_id"    => "0",
            "core_id"        => "9",
            "apicid"         => "19",
            "initial_apicid" => "19",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "17",
            "physical_id"    => "0",
            "core_id"        => "10",
            "apicid"         => "21",
            "initial_apicid" => "21",
            "bogomips"       => "6133.05",
          }),
          p0.merge({
            "processor"      => "18",
            "physical_id"    => "1",
            "core_id"        => "0",
            "apicid"         => "33",
            "initial_apicid" => "33",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "19",
            "physical_id"    => "1",
            "core_id"        => "1",
            "apicid"         => "35",
            "initial_apicid" => "35",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "20",
            "physical_id"    => "1",
            "core_id"        => "2",
            "apicid"         => "37",
            "initial_apicid" => "37",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "21",
            "physical_id"    => "1",
            "core_id"        => "8",
            "apicid"         => "49",
            "initial_apicid" => "49",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "22",
            "physical_id"    => "1",
            "core_id"        => "9",
            "apicid"         => "51",
            "initial_apicid" => "51",
            "bogomips"       => "6133.17",
          }),
          p0.merge({
            "processor"      => "23",
            "physical_id"    => "1",
            "core_id"        => "10",
            "apicid"         => "53",
            "initial_apicid" => "53",
            "bogomips"       => "6133.17",
          }),
        ]
      end

    end

  end
end
