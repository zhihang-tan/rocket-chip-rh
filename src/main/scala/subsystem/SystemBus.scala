// See LICENSE.SiFive for license details.

package freechips.rocketchip.subsystem

import org.chipsalliance.cde.config.{Parameters}
import freechips.rocketchip.devices.tilelink._
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.tilelink._
import freechips.rocketchip.util._
import chisel3._
import chisel3.experimental.dataview.BundleUpcastable
import chisel3.util._
import freechips.rocketchip.subsystem.{BaseSubsystem, HasTiles}
import freechips.rocketchip.subsystem.{BaseSubsystem, BankedL2Params}
import freechips.rocketchip.prci.{ClockSinkDomain}
import org.chipsalliance.cde.config.{Field, Parameters}

case class SystemBusParams(
    beatBytes: Int,
    blockBytes: Int,
    policy: TLArbiter.Policy = TLArbiter.roundRobin,
    dtsFrequency: Option[BigInt] = None,
    zeroDevice: Option[BuiltInZeroDeviceParams] = None,
    errorDevice: Option[BuiltInErrorDeviceParams] = None,
    replication: Option[ReplicatedRegion] = None)
  extends HasTLBusParams
  with HasBuiltInDeviceParams
  with TLBusWrapperInstantiationLike
{
  def instantiate(context: HasTileLinkLocations, loc: Location[TLBusWrapper])(implicit p: Parameters): SystemBus = {
    val sbus = LazyModule(new SystemBus(this, loc.name))
    sbus.suggestName(loc.name)
    context.tlBusWrapperLocationMap += (loc -> sbus)
    sbus
  }
}

class SystemBus(params: SystemBusParams, name: String = "system_bus")(implicit p: Parameters)
    extends TLBusWrapper(params, name)
{
  private val replicator = params.replication.map(r => LazyModule(new RegionReplicator(r)))
  val prefixNode = replicator.map { r =>
    r.prefix := addressPrefixNexusNode
    addressPrefixNexusNode
  }

  private val system_bus_xbar = LazyModule(new TLXbar(policy = params.policy))
  val inwardNode: TLInwardNode = system_bus_xbar.node :=* TLFIFOFixer(TLFIFOFixer.allVolatile) :=* replicator.map(_.node).getOrElse(TLTempNode())
  val outwardNode: TLOutwardNode = system_bus_xbar.node
  def busView: TLEdge = system_bus_xbar.node.edges.in.head

  //===== rrunahead: Start ====//
  // def attach(subsystem: BaseSubsystem with HasTiles with BankedL2Params)
  // (implicit p: Parameters){
  //   val l2_hit_sbus = BundleBridgeSink[UInt](Some(() => Bool()))
  //   // subsystem.ins_outtile_hit := l2_hit_sbus
  // }


  //===== rrunahead: End ====//


  val builtInDevices: BuiltInDevices = BuiltInDevices.attach(params, outwardNode)
}
